# Raw Sources

Drop your raw source materials here. These are the unprocessed inputs that the LLM will read and convert into structured wiki articles.

## Supported Formats

- **PDF** -- research papers, textbooks, reports
- **Markdown** -- blog posts, notes, documentation
- **Plain text** -- transcripts, meeting notes, raw dumps
- **HTML** -- saved web pages, documentation exports
- **Images** -- diagrams, screenshots (if your LLM supports vision)

## Organization Tips

1. Use descriptive filenames: `attention-is-all-you-need-2017.pdf` not `paper3.pdf`
2. Create subdirectories by topic if you have many sources: `raw/transformers/`, `raw/rl/`
3. Keep original files unmodified -- the wiki articles are the refined output
4. Add a short `_sources.md` manifest if you want to track what you've already ingested

## Workflow

1. Drop files here
2. Run the ingest prompt (`prompts/ingest.md`) with your LLM
3. The LLM reads the raw source and creates/updates articles in `wiki/`
4. The original file stays here as a permanent reference
