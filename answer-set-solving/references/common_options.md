## Common clingo Options

The hardened wrapper already adds `--warn=all` and `--stats=2` by default. Add the flags below after the input files when you need more control.

- Full solver statistics: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --stats=2`
- One model, which is usually the right default while debugging: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --models 1`
- All models: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --models 0`
- Count models without printing every witness: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --models 0 --quiet=2 --stats=2`
- Emit machine-readable JSON output: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --models 0 --outf=2`
- Keep only the last model and last cost in text output: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --models 0 --quiet=1`
- Enumerate optimal models after proving the optimum: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp --opt-mode=optN --models 0`
- Use two solver threads for search-heavy runs: `./scripts/run-clingo-hardened.sh encoding.lp instance.lp -t2`
- Inspect the grounded plain-text program directly: `python3 -m clingo --mode=gringo --text encoding.lp instance.lp`

Notes:

- `--models 0` means no model limit, not zero models.
- `--opt-mode=optN` is the standard choice when you want all optimal models, while `--opt-mode=enum,<bound>` is useful when you already know a cost bound and want models up to that bound.
- For multi-criteria optimization, pass one bound per objective level in `--opt-mode=enum,<bound>...` or `--opt-stop=<bound>...`.
- Parallel search with `-t2` can help on hard instances, but keep benchmarking comparisons on the same thread count.
