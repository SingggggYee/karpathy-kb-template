# Knowledge Base Project -- Claude Code Instructions

This is an LLM-powered personal knowledge base built on the Karpathy KB Template.

## Project Structure

- `raw/` -- Unprocessed source documents (PDFs, markdown, text)
- `wiki/` -- Structured markdown wiki articles with YAML frontmatter
- `wiki/_index.md` -- Master index of all articles
- `wiki/_templates/` -- Article templates (concept, source-summary, comparison)
- `output/` -- Generated artifacts (slides, reports, visualizations)
- `prompts/` -- LLM prompt templates for wiki operations
- `scripts/` -- Shell script utilities

## Workflow

The core workflow is: raw source -> ingest prompt -> wiki articles.

1. **Ingest**: User adds a file to `raw/`, then runs the ingest prompt to create wiki articles
2. **Compile**: User runs the compile prompt to synthesize and reorganize the wiki
3. **Query**: User runs the query prompt to ask questions against the wiki
4. **Lint**: User runs the lint prompt to check wiki health

## When Working With This Project

- **Always preserve frontmatter** in wiki articles (the YAML block between `---` markers)
- **Use `[[wiki-links]]`** for cross-references between articles
- **Follow templates** in `wiki/_templates/` when creating new articles
- **Update `wiki/_index.md`** whenever articles are added or removed
- **Never modify files in `raw/`** -- those are source-of-truth originals
- **Keep articles atomic** -- one concept per article, link between them

## Article Types

1. **Concept** (`wiki/concepts/`) -- Explains a single concept with overview, key ideas, connections
2. **Source Summary** (`wiki/sources/`) -- Summarizes a single source document with key contributions
3. **Comparison** (`wiki/comparisons/`) -- Side-by-side comparison of two related concepts

## Conventions

- Filenames: `kebab-case.md` (e.g., `transformer-architecture.md`)
- Frontmatter fields: `title`, `tags`, `sources`, `related`, `created`, `updated`, `confidence`
- Confidence levels: `high` (multiple sources), `medium` (single source), `low` (uncertain/speculative)
- Backlinks: every article should link to related articles and back to its sources
