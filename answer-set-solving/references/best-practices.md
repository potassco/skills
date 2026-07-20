# ASP Best Practices

## Model The Interface First

- Keep instance predicates, decision predicates, and shown predicates clearly separated.
- Use `#show` to define the output contract explicitly.
- Keep shown predicates minimal; they are both the user-facing interface and often the right notion of semantic equivalence.
- If a downstream checker expects a witness shape, optimize internal predicates but preserve the shown witness vocabulary.

## Name Variables And Format Consistently

- Pick one variable name per semantic kind and reuse it consistently across the encoding and its documentation. If a rule talks about persons, keep using `P`; if it talks about nodes or vertices, keep using `V` or `N`; do not alternate between unrelated names for the same role.
- When several variables of the same kind appear together, prefer prime-style variants such as `V`, `V'`, and `V''` so the shared role stays obvious.
- Keep predicate arguments visually separated with spaces after commas, but not immediately inside parentheses. Prefer `edge(V, V')` and `assign(P, room1)` over denser forms like `edge(V,V')`.
- Put spaces after commas and around infix operators and comparisons so joins, guards, and arithmetic stay readable.
- If a rule body, aggregate, or optimization statement becomes long, break it across lines and indent continuation lines consistently.

## Control Grounding Size

- Bind every variable through domain predicates or safe positive literals.
- Prefer domain predicates over repeating large joins inline.
- Inspect grounding when a rule conceptually looks quadratic or worse.
- Use `#const` for tunable bounds instead of editing the source for each run.
- Avoid arithmetic or equality tricks that make domains implicit and hard to reason about.

## Prefer Simpler Language Constructs When They Fit

- A common ASP pattern is to generate the search space first with choice rules over a tight domain, then narrow it with integrity constraints. Start by making candidate solutions explicit, and only then add rules that forbid invalid combinations.
- Prefer choice rules to disjunction unless you need the stronger complexity or semantics of disjunction.
- Use integrity constraints to rule out bad states rather than encoding indirect negated consequences everywhere.
- Introduce helper predicates when they cut repeated joins or repeated aggregate conditions.
- Push deterministic derivations into normal rules and keep choices for actual decisions.

## Use Aggregates Carefully

- Remember aggregates operate on sets of tuples; duplicates are removed unless the tuple carries distinguishing terms.
- Be careful with aggregate assignments of the form `X = #sum { ... }` when the aggregate depends on non-domain predicates. This can cause grounding blow-ups.
- Prefer direct comparisons like `#sum { ... } > 3` when the value does not need to be bound to a variable.

## Tightness And Positive Cycles

- Keep the program tight unless positive recursion is genuinely part of the model.
- Positive cycles should appear only when intended, such as reachability, transitive closure, inductive definitions, or similar recursive constructions.
- Treat accidental cycles as a modeling smell; they often hide unclear dependencies, make debugging harder, and can hurt solver behavior.
- Check tightness with `--stats=2`. In the solver statistics, prefer `Tight : Yes` for non-recursive encodings.
- Also inspect the number of strongly connected components in the positive dependency graph. For encodings that are meant to be tight, the SCC count associated with recursive components should stay at `0`.
- If the model is unexpectedly non-tight, inspect which predicates depend positively on each other and break the cycle by introducing a clearer level mapping, a domain predicate, or a one-way helper predicate.
- When recursion is intentional, isolate it to the smallest possible part of the encoding and keep the rest of the model acyclic.

## Optimization And Performance

- Keep optimization predicates close to real decisions, not derived presentation atoms.
- Use priorities to separate objective layers cleanly.
- Check whether an objective should minimize the number of chosen items, total cost, or a lexicographic tuple, and encode that directly.
- Benchmark before and after each optimization change; performance tuning without measurements is guesswork.
- Reduce large joins by introducing tighter domain predicates.
- Eliminate unused derivations and unnecessary symmetry early; these are exactly the kinds of rewrites ngo can help with.

## Heuristics And API Use

- Start with a correct model and grounding review before adding `#heuristic` directives or solver flags.
- Use `--heuristic=Domain` only when you have a concrete domain reason for preferring certain choices.
- Treat heuristics as search guidance, not as a repair mechanism for wrong encodings.
- Use `--stats=2` to verify whether a heuristic meaningfully reduces choices or conflicts.
- Use multi-shot solving only when the task genuinely benefits from incremental grounding or external control.
- For Python integrations, use the clingo Python API to control grounding and solving explicitly rather than shelling out repeatedly when you need iterative interaction.
