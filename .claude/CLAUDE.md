# Claude Code -- Knowledge Base Workflow Instructions

You are working inside a personal knowledge base project. This file provides detailed instructions for how to operate within this codebase.

## Understanding the Architecture

```
raw/          Input: unprocessed source documents
    |
    v         [ingest prompt]
wiki/         Storage: structured markdown articles with frontmatter
    |
    v         [compile/query/slides/visualize prompts]
output/       Output: reports, slides, diagrams
```

## Core Operations

### Ingesting a New Source

When the user asks you to ingest a document:

1. Read the source document from `raw/`
2. Identify key concepts, contributions, and relationships
3. For each concept, check if `wiki/concepts/{concept}.md` already exists
   - If yes: update the existing article, add this source to frontmatter, merge new information
   - If no: create a new article using the template at `wiki/_templates/concept.md`
4. Create a source summary at `wiki/sources/{source-name}.md` using `wiki/_templates/source-summary.md`
5. If applicable, create comparison articles using `wiki/_templates/comparison.md`
6. Add `[[backlinks]]` between all related articles
7. Update `wiki/_index.md` with new articles and accurate statistics

### Querying the Wiki

When the user asks a question:

1. Search wiki articles for relevant content
2. Synthesize an answer citing specific articles with `[[wiki-links]]`
3. Distinguish between what the wiki says and what you know independently
4. Flag articles with `confidence: low` if citing them
5. Identify gaps where the wiki lacks coverage

### Compiling the Wiki

When the user asks to compile or reorganize:

1. Read all articles and map the knowledge graph
2. Identify topic clusters, orphans, and gaps
3. Produce synthesized reports in `output/reports/`
4. Update the index with better organization

### Linting the Wiki

When the user asks to lint or health-check:

1. Check for broken `[[wiki-links]]`
2. Find orphan articles (no incoming links)
3. Identify thin articles (too short or still templated)
4. Verify frontmatter completeness
5. Check index accuracy

## File Conventions

- All wiki articles use YAML frontmatter between `---` markers
- Cross-references use `[[article-name]]` Obsidian-style wiki-links
- Filenames are `kebab-case.md`
- Directories: `concepts/`, `sources/`, `comparisons/`
- Templates are in `wiki/_templates/` and should never be modified by operations
- The `raw/` directory is read-only -- never modify source documents

## Quality Standards

- Every concept article should have: overview, key ideas, connections, at least one source
- Every source summary should have: bibliographic info, key contributions, summary, concepts extracted
- Every article should link to at least one other article
- The index should always be up to date
- Confidence levels should reflect source coverage:
  - `high`: corroborated by 2+ independent sources
  - `medium`: based on a single source
  - `low`: speculative or uncertain

## Common Pitfalls

- Do not create duplicate articles for the same concept under different names
- Do not forget to update the index after adding articles
- Do not leave template placeholders (e.g., `{{CONCEPT_NAME}}`) in published articles
- Do not add information to wiki articles that is not grounded in a source document
