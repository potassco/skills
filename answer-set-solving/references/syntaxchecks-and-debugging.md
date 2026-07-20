# Syntax And Debugging

## Fast Checks

Run a syntax pass first:

```bash
./skills/answer-set-solving/scripts/check-syntax.sh encoding.lp instance.lp
```

This uses the clingo Python AST parser under explicit time and memory limits, so it catches:
- parse errors
- malformed directives

It does not fully ground the program. Use grounding inspection or a bounded solve when you need grounding-time diagnostics such as unsafe variables or domain blow-ups.

Inspect grounding when syntax passes but behavior looks wrong:

```bash
./skills/answer-set-solving/scripts/inspect-grounding.sh encoding.lp instance.lp > grounded.lp
```

Use grounding inspection when:
- a rule is too permissive or too restrictive
- an aggregate behaves unexpectedly
- `#show` output is empty even though the model should exist
- a variable seems bound to a much larger domain than intended

## Hardened Solving

Run clingo with explicit limits:

```bash
CLINGO_TIMEOUT_SECONDS=300 \
CLINGO_MEMORY_LIMIT_MB=8192 \
./skills/answer-set-solving/scripts/run-clingo-hardened.sh encoding.lp instance.lp --models 1
```

The wrapper adds:
- `--warn=all`
- `--stats=2` by default
- `timeout` if available
- `ulimit -Sv` memory capping

This is useful when the task is exploratory and you do not want unbounded runs.

## What To Check First

- Empty output: verify `#show` directives before changing the model.
- Too many atoms in output: project the witness with `#show` or a dedicated post-processing predicate.
- UNSAT after a refactor: inspect integrity constraints and support, then compare grounded rules before and after the change.
- Slow solving: check grounding size first, then solver statistics, then consider structural rewrites or ngo.
- Unexpected costs: inspect `#minimize` or weak constraints and confirm priorities match the intended lexicographic order.
