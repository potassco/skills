# Correctness Checks With Python

Use a Python checker when answer sets must satisfy problem-specific properties such as connectivity, supported edges, or every non-root child having exactly one parent, etc...

The template uses the clingo Python API through Clorm. It accepts LP files, a `--models` limit, and treats `-` as standard input:

```bash
python check_answer_set.py encoding.lp instance.lp
cat facts.lp | python check_answer_set.py -
cat instance.lp | python check_answer_set.py encoding.lp -
```

## Template

```python
import argparse
import sys
from collections import deque
from pathlib import Path

from clorm import ConstantField, Predicate
from clorm.clingo import Control


class Node(Predicate):
    name = ConstantField


class Edge(Predicate):
    source = ConstantField
    target = ConstantField


class Root(Predicate):
    node = ConstantField


class Parent(Predicate):
    child = ConstantField
    parent = ConstantField


def answer_sets(paths: list[str], models: int):
    control = Control(["--warn=all", f"--models={models}"], unifier=[Node, Edge, Root, Parent])
    for path in paths:
        if path == "-":
            control.add("base", [], sys.stdin.read())
        else:
            control.load(str(Path(path)))
    control.ground([("base", [])])
    with control.solve(yield_=True) as handle:
        for model in handle:
            yield model.facts(atoms=True)


def check(facts) -> None:
    nodes = set(facts.query(Node).select(Node.name).all())
    root = facts.query(Root).singleton().node
    assert facts.query(Node).where(Node.name == root).count() == 1, f"root {root} is not declared as node/1"

    for parent_atom in facts.query(Parent).all():
        child = parent_atom.child
        parent = parent_atom.parent
        assert facts.query(Node).where(Node.name == child).count() == 1, f"unknown child {child}"
        assert facts.query(Node).where(Node.name == parent).count() == 1, f"unknown parent {parent}"
        assert (
            facts.query(Edge).where(Edge.source == parent, Edge.target == child).count() == 1
        ), f"parent({child},{parent}) has no edge({parent},{child})"

    assert facts.query(Parent).where(Parent.child == root).count() == 0, f"root {root} must not have a parent"
    for node in nodes - {root}:
        parent_count = facts.query(Parent).where(Parent.child == node).count()
        assert parent_count == 1, f"node {node} has {parent_count} parents"

    seen = {root}
    queue = deque([root])
    while queue:
        node = queue.popleft()
        for child in facts.query(Parent).where(Parent.parent == node).select(Parent.child).all():
            if child in seen:
                continue
            seen.add(child)
            queue.append(child)
    assert seen == nodes, f"unreachable nodes: {sorted(nodes - seen)}"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("program", nargs="*", default=["-"], help="LP files; use '-' for stdin")
    parser.add_argument("--models", type=int, default=1, help="number of answer sets to check; 0 means all")
    args = parser.parse_args()

    found = False
    for facts in answer_sets(args.program, args.models):
        found = True
        check(facts)
    if not found:
        print("No answer set found.")
        return
    print("OK")


if __name__ == "__main__":
    main()
```

## Smoke Test

```bash
cat <<'EOF' | python check_answer_set.py -
node(a). node(b). node(c).
edge(a,b). edge(b,c).
root(a).
parent(b,a). parent(c,b).
EOF
```

Expected output:

```text
OK
```

If no answer set is found, the template only prints that information because satisfiable versus unsatisfiable is instance-dependent and not automatically a correctness error.

For a real problem, replace the predicate classes and assertions with the public predicates and invariants of the encoding under test. Keep the checker focused on answer-set properties, not on reimplementing the whole encoding.