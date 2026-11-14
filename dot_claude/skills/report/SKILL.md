---
name: report
description: Write or revise a Markdown document for managers or researchers (proposal, review, comparison, plan, argument), with TL;DR, embedded plots, appendices, Sources, and a live preview. Use when drafting or editing the deliverable of a cowork project.
---

# Report

Documents are Markdown in the project root, read by managers and researchers, previewed live while drafting. Writing
style is in `~/.claude/rules/writing-style.md`; plots follow the `plots` skill.

## Shape

- `# Title`, then `## TL;DR` with five to seven bullets and the most important plot under them.
- Numbered sections follow, then lettered appendices for assumptions, method, and data tables, then `## Sources`.
- **Details move down.** Data periods, caveats about a source, and calculations go to an appendix, not the TL;DR.
- Embed plots as `![Alt text that says what the plot shows](plots/out/<name>.png)`, the `_slim` variant in the body
  and the full plot in an appendix.
- **Editorial notes** go in HTML comments. The preview shows them as highlighted boxes; they do not publish.
- Name exact products, models, and judges; say which judge produced each result.

## Sources

- `## Sources` at the end, grouped by type (wiki pages, chat threads, tables and queries, code and data paths, web).
  Links are exact, to the page or message, not to a space or channel.
- Inline links at the claim, so a reader can follow one number without scrolling.
- Long evidence goes in a separate sources file (for reviews, `<name>-sources.md` with collection date, period, and
  gaps). When sources disagree, say which one was used and why.
- Mark what is unchecked with `[check]`, or "not verified against the source system".

## Live preview

After creating or changing a document, start the preview in the background and give Markus the URL. Copy
`preview/serve.py` from the reference project named in the repo's CLAUDE.md, set `DOC`, pick a free port, and run
`uv run --with markdown python preview/serve.py [port]` from the project root. It re-renders on save and keeps the
scroll position.

## Before delivering

1. Run the greps from the writing-style rule and fix every hit.
2. Check that every number in the TL;DR appears, with its source, in a section or appendix.
3. Check that every embedded image path exists.
4. Read the TL;DR alone: does it state the conclusion and what is asked of the reader?

## Gotchas

- Numbers copied into prose go stale when plots are re-run; after re-running a plot script, re-check the numbers
  quoted from it.
- Mermaid: no subgraphs; check the render at phone width.
- Body text is paragraphs; bullets only in the TL;DR and the asks.
- Prose around a plot gives its meaning and source, not its numbers. Tables that repeat a plot go to an appendix.
- Gaps go in one list in an appendix or the project CLAUDE.md, never as "Missing:" paragraphs in the body.
- Run IDs, model ID columns, benchmark specs, and re-explanations of names already defined stay out of the body;
  checkpoint names go in HTML comments.
- Describe weak evidence by its size and coverage instead of doubting it: "not proven yet", "same ballpark" when
  intervals overlap, and "research prototype" for every model that has not shipped.
- When cutting body text, move the parts that carry an argument to an appendix instead of deleting them.
- After Markus edits the TL;DR, keep its structure and check that nothing in the body contradicts it.
- Before publishing, a subagent checks every external number against its cited source.
- Never overwrite a Confluence page with open review comments without asking. Appendices and Sources go in an
  expand macro.
- Scripts that publish a deliverable (Markdown to Confluence, attachment upload) live in the project's `publish/`,
  never only in a scratchpad.
- Every count in a table names its unit (per segment, per text, per request).
- When the data behind a scenario parameter is thin, propose round assumptions and label them, instead of deriving a
  fudged value.
- Check paraphrased quotes against the Granola transcript before they go into a draft.
