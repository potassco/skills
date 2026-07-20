---
name: answer-set-solving
description: 'Use for Answer Set Programming with clingo, clorm, and ngo and, more generally, for hard combinatorial search or optimization problems with exponential runtime where clingo is a good fit: writing or reviewing encodings, syntax checking, grounding inspection, debugging UNSAT or empty outputs, checking answer-set correctness, optimizing #minimize or weak constraints, improving performance, and running bounded solver commands. Trigger for ASP, answer sets, clingo, clorm, gringo, ngo, SAT-like search, combinatorial optimization, scheduling, graph problems, aggregates, #show, heuristics, and non-ground optimization.'
argument-hint: '[task] [encoding.lp] [instance.lp] [goal: model|debug|optimize|ngo]'
user-invocable: true
---

# Answer Set Solving

Use this skill for ASP work with clingo, gringo, ngo, or hard combinatorial search and optimization problems where a clingo model is plausible.

Typical tasks: write or review encodings, check syntax and safety, inspect grounding, debug UNSAT or empty witnesses, validate answer-set correctness, tune performance, run ngo, or decide whether ASP fits a search-heavy problem.

## Installation

This skill expects `python3` and access to `clingo`, with optional `ngo` for non-ground optimization and `clorm` for Python answer-set checks.

Use [installation.md](references/installation.md) for official install routes, package-manager pointers, and post-install verification commands.

## Start Here

- Start with the public interface and modeling guidance in [best-practices.md](./references/best-practices.md).
- For syntax passes, grounding inspection, and bounded runs, use [syntaxchecks-and-debugging.md](./references/syntaxchecks-and-debugging.md).
- For Python-based answer-set validation, adapt the template in [correctness.md](./references/correctness.md).
- For solver flags during debugging or benchmarking, use [common_options.md](./references/common_options.md).
- For ngo usage and clingo API notes, use [clingo-ngo.md](./references/clingo-ngo.md).
- If the environment is missing clingo, ngo, or clorm, start with [installation.md](references/installation.md).

## Bundled Scripts

These scripts are the supported entry points for local checks and bounded runs. See the linked references for when to use each one and for full command examples.

- [check-syntax.sh](./scripts/check-syntax.sh): parse-only syntax and directive checks.
- [inspect-grounding.sh](./scripts/inspect-grounding.sh): dump the grounded program for debugging domains, aggregates, and `#show` behavior.
- [run-clingo-hardened.sh](./scripts/run-clingo-hardened.sh): bounded solving with warnings and stats enabled.
- [run-ngo.sh](./scripts/run-ngo.sh): non-ground optimization before re-checking syntax and behavior.

## Read Next

- [documentation.md](./references/documentation.md) for documenting encodings and public predicates.
- [installation.md](references/installation.md) for installing clingo, ngo, and clorm.
- [docs_and_sources.md](./references/docs_and_sources.md) for official clingo, ngo, and ASP-Core references.

## References

- [Bundled reference notes](./references/)
- [Best practices](./references/best-practices.md)
- [Encoding documentation](./references/documentation.md)
- [Installation](references/installation.md)
- [Syntax and debugging](./references/syntaxchecks-and-debugging.md)
- [Common clingo options](./references/common_options.md)
- [Correctness checks with Python](./references/correctness.md)
- [Clingo and ngo notes](./references/clingo-ngo.md)
- [Docs and sources](./references/docs_and_sources.md)
- [Syntax checker script](./scripts/check-syntax.sh)
- [Grounding inspection script](./scripts/inspect-grounding.sh)
- [Hardened clingo runner](./scripts/run-clingo-hardened.sh)
- [ngo runner](./scripts/run-ngo.sh)