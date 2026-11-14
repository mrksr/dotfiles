---
name: plots
description: Make or change a figure or a dense table for a report, deck, or analysis, in matplotlib or great_tables, including the render-and-review loop. Use whenever a plot script is written or edited, a figure is regenerated for a document, or a table needs sparklines or heavy formatting.
---

# Plots

The aesthetic lives in code, not in each plot. Every figure goes through the project's style module (or the shared
style package once a project uses it): palette, fonts, `save()`. Do not restyle per plot. The repo's CLAUDE.md names
the reference project and the brand palette.

## Layout

```
plots/
  pyproject.toml, uv.lock   one environment per project, .venv/ not committed
  style.py                  palette, fonts, save(); or a dependency on the style package
  load.py                   loads data/; holds display names and system order
  charts.py                 shared chart builders so related plots look identical
  <plot>.py                 one script per figure, docstring says what it shows
  out/                      png and svg of every figure (committed)
```

Run with `cd plots && uv run python <plot>.py`. Display names and order come from `load.py`, never typed into a plot.

## Rules

- **The title states the finding**, for example "Both levers bring customisation to a few seconds, but long texts
  still take tens of seconds". The subtitle gives data, judge, and sample size. A TL;DR or slide plot may take a short
  noun title ("Cost per request estimates") with a one-line subtitle.
- **Axis labels say which direction is better**, with units: "1 to 10 blind test scale (lower is better)".
- **Uncertainty is shown**: standard error bars or 95% CIs. Say which in the subtitle or caption.
- Bars for scores start at the best possible score. No top or right spines.
- Direct labels over legends where there is room.
- Human-rated and LLM-judged data are told apart by the lighter colour variant and a corner tag.
- A `_slim` variant exists for figures in the document body; the full one goes in an appendix.
- Save through `style.save()`: png and svg at 200 dpi into `plots/out/`.

## Review loop

Run after creating a figure or changing how one looks. Do not skip it because the code "looks right".

1. **Render**: run the script and confirm the png in `plots/out/` is new.
2. **Review**: spawn a reviewer subagent that gets only the png path, the intended finding (one sentence), and the
   checklist below, and not the code. Ask it for at most 5 issues, most important first, each tied to a checklist item
   or a concrete visual problem.
3. **Fix** the issues in the plot script, or in `charts.py` or `style.py` when the issue would recur in other plots.
4. **Stop** after a clean review or 3 rounds. Report what is left as a short list to Markus instead of looping.
5. **Lock**: if the same fix was needed twice, propose a line for Gotchas below or a change to the style module.

Checklist for the reviewer:

- Title states the finding (or a short noun title on a TL;DR or slide plot); subtitle gives data, judge, and n
- Axis labels say which direction is better, with units
- Uncertainty is visible and its kind is stated
- Colours and system order match the rest of the project
- Human-rated vs LLM-judged is visible (colour variant, corner tag)
- No clipped, overlapping, or illegible labels; tick labels are round numbers
- Score bars start at the best possible score
- Readable at the `_slim` size used in the document body
- Nothing on the figure that the finding does not need

## Dense tables

For appendix tables and summary grids, use `great_tables` (`GT`) with the project palette:

- `fmt_number` / `fmt_percent` with fixed decimals per column, `tab_spanner` for grouped columns.
- `fmt_nanoplot()` puts a sparkline or small bar chart in a cell, for example per-language scores over time.
- `data_color()` with the palette for heatmap-style cells; keep text contrast readable.
- Save html for previews; `GT.save()` to png needs a headless browser [check on this machine].

## Gotchas

- Read the rendered png yourself before saying a plot is fine; the code alone does not show clipping or overlap.
- Drop any series, quantile, or whisker that does not change the conclusion. A supporting plot starts as one
  aggregate bar per system; add breakdowns on request.
- Estimates (derived from evals or assumptions, not measured) carry an "Estimate" corner tag.
- A subtitle is never wider than the title; wrap it to two lines.
- Before the first plot, propose display names that say what each checkpoint is, not run-name fragments, and use one
  name per system in text, tables, and plots.
