# Clingo, ngo, And Further Reading

## Clingo And Gringo

- clingo combines gringo's grounding with clasp's solving in one system. Many ASP failures are grounding failures before they become solving failures.
- Use `--mode=gringo --text` to inspect what the solver actually sees.
- Use `--models`, `--outf=2`, and `--stats=2` deliberately when you need controlled enumeration, structured output, or benchmarking data.
- The Potassco guide is still the best single reference for language constructs, aggregates, optimization, heuristics, `#show`, `#const`, `#external`, and program parts.

## High-Value Clingo Guidance

- Variables must be safe.
- Choice constructs are often preferable to disjunction when the stronger semantics of disjunction are unnecessary.
- Aggregates are set-based, not multiset-based, unless tuples are made distinct.
- Binding aggregate values with `=` should be used carefully because it can enlarge the grounding.
- `#show`, `#const`, `#external`, and `#program` are first-class tools for shaping output and incremental workflows.

## clingo Python API

Use the clingo Python API when the workflow needs more than one-shot solving, such as:
- multi-shot or incremental solving
- custom grounding and solve loops
- programmatic control of assumptions or externals
- structured access to models, costs, and solver events

Useful entry points include `clingo.Control`, `clingo.ast`, `clingo.Symbol`, and the related `clingox` utilities.

## ngo

ngo is a non-ground optimizer for ASP encodings. It rewrites the source program before grounding to improve performance.

The current ngo CLI reads the program from standard input and can auto-detect input predicates as predicates that are not derivable in rule heads, and auto-detect output predicates from `#show` statements. Auto-detection is convenient, but explicit predicates are safer when helper predicates resemble external input, output is post-processed outside `#show`, or preserving a stable public contract matters more than maximizing rewrites.

A typical workflow is:

```bash
NGO_INPUT_PREDICATES='auto' \
NGO_OUTPUT_PREDICATES='selected/2' \
./skills/answer-set-solving/scripts/run-ngo.sh encoding.lp > optimized.lp
./skills/answer-set-solving/scripts/check-syntax.sh optimized.lp instance.lp
./skills/answer-set-solving/scripts/run-clingo-hardened.sh optimized.lp instance.lp --models 1
```
