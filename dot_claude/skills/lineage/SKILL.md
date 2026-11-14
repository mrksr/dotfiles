---
name: lineage
description: Record where data came from when copying a dataset into a project, deriving files from it, or citing a number from a query. Use whenever files are added under a project's data/ folder or a derived CSV is written.
---

# Data lineage

Every project with data has `DATA_LINEAGE.md` at its root, and every dataset folder has a `README.md`. Together they
let someone find the original of any file later. Write the lineage when the data is copied, not afterwards.

## Layout

- `data/<source>_<YYYY-MM-DD>/` per dataset, for example `joint_model_2026-10-16`. Raw copies mirror the source
  layout under `raw/`. Derived files sit directly in `data/` and are written by a script in `plots/`, never by hand.
- git-lfs for all data: `.gitattributes` holds `data/** filter=lfs diff=lfs merge=lfs -text`. Add it when creating
  `data/`, before the first data commit.
- Keep copies lean: copy only what the plots read, and say in the dataset README what was left out and why.

## DATA_LINEAGE.md

- A table per group of files: path, what it is, origin, and **evidence** (written in a file, a handover brief, a
  document's Sources, or inferred). Mark inferred origins as inferred.
- A "Derived" table: file, the script that made it, and what it reads.
- "Gaps to close": origins nobody recorded, such as an unsaved query or an archive with no known source.
- A note that nothing was checked against the source system, when that is true.

## Dataset README.md

- Source as a link or exact path, and who produced the run.
- "Raw data (copied DD Mon YYYY)": exact source path, what each file contains, names that need explaining.
- What was **not** copied.
- Anything a later reader must not redo ("the parquet files already exclude skipped documents, do not filter again").
- Whether the copy reproduces the source's published summary numbers, when checked.

## Rules

- Exact paths, links, table names, and time windows. Never "from the eval".
- If a plot needs a file from another project, copy it into this project's `data/` and record the origin.
- If a number comes from a query that is not saved, say so, and save the query next to the CSV when possible.

## Gotchas

- Copy from a colleague's folder with one plain `tar -c` through the read-only mount, never rsync with delete flags.
