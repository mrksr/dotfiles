---
name: retro
description: Close or pause a cowork project, harvest what was learned into skills and CLAUDE.md files, and refresh the repo's INDEX.md. Use when Markus says a project is done, parked, or asks for a retro, or to backfill front matter and the index.
---

# Retro

Lessons should already be captured when they happen (see "Learning from corrections" in `~/.claude/CLAUDE.md`).
A retro harvests what was missed and makes the project findable later. Everything is proposed as a diff first.

## 1. Gather

- The project's `CLAUDE.md`, `README.md`, and any `cowork-brief-*.md`.
- `git log --stat -- <project>/` for what was done and when.
- Session transcripts: `$CLAUDE_CONFIG_DIR/projects/<repo-key>/*.jsonl` (default `~/.claude/projects/`; the key is the
  repo path with `/` replaced by `-`). Search them with `rg -l '<project folder name>'` and read only matching
  sessions, through a subagent if there are more than two, asking for corrections Markus gave, approaches he
  rejected, and things that took several attempts.

## 2. Propose

Present one list, grouped, each item with its target file:

- **Front matter** for the project README (schema below), if missing or outdated.
- **Gotchas lines** for skills. Shared skills live in the chezmoi source:
  `~/.local/share/chezmoi/dot_claude/skills/<name>/SKILL.md`; edit there, never in `~/.claude/skills/` directly.
- **CLAUDE.md lines** for the repo root or `~/.claude/CLAUDE.md` (via the chezmoi source), only for rules that apply
  beyond this project.
- **Project CLAUDE.md**: final status, open items that remain, decisions that were superseded.

Each lesson is one line, states the rule rather than the incident, and is not already covered. Prefer fewer, sharper
lines; propose deleting a line that turned out wrong.

## 3. Apply

After Markus agrees: write the changes, run `uv run ~/.claude/skills/retro/build_index.py <repo root>` to refresh
`INDEX.md`, and commit per the repo's rules (chezmoi source changes in the dotfiles repo, separately).

## Front matter schema

```yaml
---
summary: One line, what the project is and its result
kind: analysis | report | proposal | review | deck | dashboard | smart-home | homelab | tooling | stub
status: active | done | parked
tags: [joint-model, eval]
deliverable: document.md or a URL
reusable: [plots/style.py, preview/serve.py]
---
```

For a stub project (work in another repo), add `repo:` and `branch:` or `mr:`.

## Gotchas

- Self-hosted services (Forgejo, Keycloak, Proxmox) are `homelab`, not `smart-home`; add a kind to the schema rather
  than stretching one.
