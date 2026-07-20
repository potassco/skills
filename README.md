# AI Agent Skills Repository

This repository is a home for reusable AI agent skills: self-contained instruction packs that teach an agent how to handle a specific domain, workflow, or toolchain.



## Installation And Placement

There is no universal installer across agent systems. The practical pattern is: keep each skill self-contained, then map it into the host tool's documented customization format.

### Claude Code

- Personal skills:
  - `~/.claude/skills/<skill-name>/SKILL.md`
- Project skills:
  - `.claude/skills/<skill-name>/SKILL.md`
- Plugin skills:
  - `<plugin>/skills/<skill-name>/SKILL.md`


### VS Code / GitHub Copilot agents

- Project skills:
  - `.github/skills/<skill-name>/SKILL.md` or
  - `.claude/skills/<skill-name>/SKILL.md` or
  - `.agents/skills/<skill-name>/SKILL.md`
- Personal skills:
  - `~/.copilot/skills/<skill-name>/SKILL.md` or
  - `~/.claude/skills/<skill-name>/SKILL.md` or
  - `~/.agents/skills/<skill-name>/SKILL.md`

