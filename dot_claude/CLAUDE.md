# Rules of engagement

Applies to every session, work and private. A repo's own CLAUDE.md adds its conventions and wins where they differ.
Writing style is in `rules/writing-style.md`.

## Projects

- Analysis, writing, and smart-home work lives in cowork repos: one top-level folder per project, named
  `YYYY-MM-topic` by when the work was relevant. Folders are self-contained: copy what a project needs and record
  where it came from.
- Before starting a new project, read the repo's `INDEX.md` (when there is one) for earlier work to build on.
- Work done in another repo (an eval run in a monorepo, a deployed dashboard) gets a stub project in the cowork repo:
  a README with repo, branch, MR, exact commands, where the results are, and the conclusions.
- Python runs through `uv`. Single standard-library scripts carry inline script metadata; anything with dependencies
  gets a `pyproject.toml` and `uv.lock`, with `.venv/` not committed.

## Working memory

- The project `CLAUDE.md` is the working memory. Keep it current during the work: status; decisions with date and who
  ("2026-11-07, Markus: inputs stay detached"); facts verified against the real system, with how; open items.
- Mark what is unchecked with `[check]` instead of leaving it out. Say where a fact came from, and do not state forum
  posts or search snippets as fact.
- When a decision is replaced, mark the old one "superseded YYYY-MM-DD by ..." instead of deleting it.
- Point to evidence (paths, links, queries, ticket IDs) rather than paraphrasing it.
- When work moves between sessions mid-task, write a handover brief (`cowork-brief-*.md`): current state, exact
  commands to resume, open tasks.

## Learning from corrections

When Markus corrects you or rejects an approach, propose one line right then for the Gotchas section of the skill
involved, or for the relevant CLAUDE.md. State the lesson, not the incident. Add it once he agrees.

## Secrets and commits

- Secrets live only in git-ignored files (`config.env`), never in scripts, CLAUDE.md, or commits. Check `git status`
  before committing.
- Commit messages: one line, sentence case, naming the change ("Add Shelly onboarding script"), no prefixes.
  When to commit is set per repo.
