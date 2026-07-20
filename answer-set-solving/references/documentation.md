# Encoding Documentation

## Comment Syntax

- Use `%` for single-line comments.
- Use `%*` and `*%` as paired delimiters for multi-line comments.
- Prefer single-line comments for short local explanations and block comments for a file header or a longer rationale.

## Document The Interface At The Top

Start each encoding with a short comment header that documents:

- The purpose of the encoding.
- The input predicates, including each predicate's meaning and parameter roles.
- The used predicates, especially important derived or decision predicates that structure the model.
- The output predicates, including the `#show` contract and the meaning of each parameter.

Keep this header aligned with the actual public interface of the file. When the encoding changes, update the header with it.

## Recommended Header Template

```prolog
% Purpose:
%   Briefly describe what the encoding decides, constructs, or optimizes.
%
% Input predicates:
%   node(Node)           - Node is a graph node.
%   edge(From, To)       - There is a directed edge from From to To.
%   weight(Node, Cost)   - Cost assigns integer Cost to Node.
%
% Used predicates:
%   chosen(From, To)     - The encoding selects edge (From, To).
%   reachable(Node)      - Node is reachable through selected edges.
%   total_cost(Cost)     - Cost is the derived objective value.
%
% Output predicates:
%   chosen(From, To)     - Edge (From, To) is part of the witness.
%   total_cost(Cost)     - Cost is the witness objective value.
```

## Practical Guidance

- Keep the purpose section short; it should explain the task, not restate every rule.
- Document only predicates that form the input, output, or conceptual interface. Do not comment every helper rule unless it needs non-obvious rationale.
- Use parameter names in the documentation that explain the role of each argument, such as `From`, `To`, `Step`, `Cost`, or `Color`.
- If an encoding has multiple files, document each file's role and keep the shared predicate vocabulary consistent across headers.