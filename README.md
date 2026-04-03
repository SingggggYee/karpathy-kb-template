# Karpathy KB Template

**An opinionated template for building LLM-powered personal knowledge bases.**

Turn raw sources -- papers, blog posts, docs, transcripts -- into a structured, interlinked markdown wiki using any LLM. Browse it in Obsidian.

> "raw data from a given number of sources is collected, then compiled by an LLM into a .md wiki, then operated on by various CLIs by the LLM to do Q&A and to incrementally enhance the wiki, and all of it viewable in Obsidian."
>
> — Andrej Karpathy, [Apr 3, 2026](https://x.com/karpathy/status/1907477278835749189)

---

[![Use Template](https://img.shields.io/badge/Use_This-Template-2ea44f?style=for-the-badge)](https://github.com/SingggggYee/karpathy-kb-template/generate) [![Stars](https://img.shields.io/github/stars/SingggggYee/karpathy-kb-template?style=for-the-badge)](https://github.com/SingggggYee/karpathy-kb-template)

## Quick Start

```bash
# 1. Clone the template
gh repo create my-knowledge-base --template SingggggYee/karpathy-kb-template --clone

# 2. Drop a source document into raw/
cp ~/Downloads/interesting-paper.pdf raw/

# 3. Ingest it with your LLM
#    Copy prompts/ingest.md into Claude / GPT-4 / etc.
#    Attach or paste the source document
#    Copy the generated articles into wiki/

# 4. Open in Obsidian
#    File > Open Vault > select this directory

# 5. Repeat. Your knowledge compounds.
```

---

## Architecture

```
                    +------------------+
                    |   Raw Sources    |
                    |  (PDFs, blogs,   |
                    |   docs, notes)   |
                    +--------+---------+
                             |
                    prompts/ingest.md
                             |
                             v
                    +------------------+
                    |   Wiki Articles  |
                    |  (concepts,      |  <-- Browse in Obsidian
                    |   summaries,     |  <-- Query with prompts/query.md
                    |   comparisons)   |  <-- Lint with prompts/lint.md
                    +--------+---------+
                             |
               +-------------+-------------+
               |             |             |
       prompts/compile  prompts/slides  prompts/visualize
               |             |             |
               v             v             v
          +--------+   +---------+   +----------+
          |Reports |   | Slides  |   | Diagrams |
          +--------+   +---------+   +----------+

                      output/
```

---

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `raw/` | Drop source documents here. PDFs, markdown, text, HTML. Never modified after ingestion. |
| `wiki/` | Structured markdown articles. The core knowledge base. Interlinked with `[[wiki-links]]`. |
| `wiki/_templates/` | Article templates for concepts, source summaries, and comparisons. |
| `output/` | Generated artifacts: compiled reports, Marp slides, Mermaid diagrams. |
| `prompts/` | Production-quality LLM prompts for every stage of the workflow. |
| `scripts/` | Shell utilities for common operations. |
| `examples/` | Sample wiki with realistic articles to show what the output looks like. |
| `.obsidian/` | Minimal Obsidian vault configuration. |

---

## Prompts Reference

These are the core prompts that drive the workflow. Each is a standalone markdown file you paste into any LLM.

| Prompt | File | Purpose |
|--------|------|---------|
| **Ingest** | `prompts/ingest.md` | Read a raw source and create structured wiki articles |
| **Compile** | `prompts/compile.md` | Audit the knowledge graph and synthesize topic reports |
| **Query** | `prompts/query.md` | Ask questions and get grounded, cited answers |
| **Lint** | `prompts/lint.md` | Health-check the wiki for broken links, orphans, gaps |
| **Slides** | `prompts/slides.md` | Generate Marp slide decks from wiki content |
| **Visualize** | `prompts/visualize.md` | Generate Mermaid diagrams and concept maps |

---

## Article Types

The wiki uses three article templates:

### Concept (`wiki/_templates/concept.md`)
Explains a single idea. Includes overview, key ideas, how it works, why it matters, connections, and sources. One concept per article -- link between them.

### Source Summary (`wiki/_templates/source-summary.md`)
Summarizes a single source document. Captures bibliographic info, key contributions, a structured summary, notable quotes, and a list of concepts extracted.

### Comparison (`wiki/_templates/comparison.md`)
Side-by-side comparison of two related approaches. Includes an at-a-glance table, detailed analysis, and guidance on when to use which.

All articles use YAML frontmatter for metadata (title, tags, sources, related, confidence level) and `[[wiki-links]]` for cross-references.

---

## Working With Obsidian

This template is an Obsidian vault out of the box. Open it with File > Open Vault.

### Recommended Plugins

| Plugin | Why |
|--------|-----|
| **Dataview** | Query articles by tags, confidence, source count. Build dynamic indexes. |
| **Graph View** (built-in) | Visualize the knowledge graph -- see how concepts connect. |
| **Templater** | Automate article creation using the templates in `wiki/_templates/`. |
| **Tag Wrangler** | Manage and rename tags across articles. |
| **Backlinks** (built-in) | See which articles reference the current one. |
| **Mermaid** (built-in) | Render architecture diagrams inline. |
| **Sliding Panes** | Open multiple articles side by side for comparison. |

### Useful Dataview Queries

Recently updated articles:
````markdown
```dataview
TABLE updated, confidence, length(sources) as "# Sources"
FROM "wiki/concepts"
SORT updated DESC
LIMIT 20
```
````

Low-confidence articles needing more sources:
````markdown
```dataview
LIST
FROM "wiki/concepts"
WHERE confidence = "low" OR confidence = "medium"
SORT confidence ASC
```
````

---

## Using with Claude Code

This template includes `CLAUDE.md` and `.claude/CLAUDE.md` with instructions for Claude Code. When you open this project in Claude Code, it will understand the knowledge base structure and can:

- Ingest sources directly (read the file, create wiki articles, update the index)
- Answer questions grounded in wiki content
- Lint and reorganize the wiki
- Generate output artifacts

```bash
# Example Claude Code workflow
claude "Ingest raw/attention-is-all-you-need.pdf into the wiki"
claude "What does the wiki say about attention mechanisms?"
claude "Lint the wiki and fix any issues"
claude "Create a slide deck about transformers from the wiki"
```

---

## Scripts

### `scripts/ingest.sh`

Copies a file into `raw/` and prints next-step instructions.

```bash
./scripts/ingest.sh ~/Downloads/paper.pdf
./scripts/ingest.sh ~/Downloads/paper.pdf ml-papers  # with subdirectory
```

### `scripts/lint.sh`

Quick structural health check: article counts, broken links, orphan articles, missing frontmatter.

```bash
./scripts/lint.sh
```

---

## Examples

The `examples/sample-wiki/` directory contains a realistic mini-wiki about transformer architectures, built from "Attention Is All You Need." Browse it to see what the output looks like:

- `examples/sample-wiki/_index.md` -- Master index
- `examples/sample-wiki/concepts/transformer-architecture.md` -- A well-formed concept article
- `examples/sample-wiki/concepts/attention-mechanism.md` -- Another concept article with cross-links
- `examples/sample-wiki/sources/attention-is-all-you-need.md` -- A source summary

---

## Tips

- **Start small.** Ingest 3-5 sources on a focused topic. A deep wiki on one topic beats a shallow wiki on ten.
- **Review LLM output.** The prompts produce high-quality articles, but always review for accuracy. Add personal notes in the "Personal Notes" section.
- **Iterate.** Re-ingest sources or run the compile prompt as your wiki grows. Connections emerge over time.
- **Use confidence levels.** Mark articles `low`/`medium`/`high` based on how many sources support them. This helps you know where to add more sources.
- **Back up.** This is a Git repo. Commit after each ingestion session.

---

## FAQ

**Q: Which LLM should I use?**
Any model with a large context window works. Claude (200K context), GPT-4 (128K), and Gemini (1M+) all handle the prompts well. For ingesting long documents, prefer models with larger context windows.

**Q: Can I use this with tools other than Obsidian?**
Yes. The wiki is plain markdown files with YAML frontmatter. Any tool that supports markdown works: VS Code, Logseq, Notion (with import), or even `grep`. Obsidian just gives you the best experience with wiki-links and graph view.

**Q: How big can the wiki get?**
There is no hard limit. Obsidian handles thousands of articles smoothly. The LLM prompts work best when you can fit the relevant portion of the wiki in the context window. For very large wikis, use the query prompt with specific articles rather than the entire wiki.

**Q: Can multiple people contribute?**
Yes. It's a Git repo with plain text files. Standard branch-and-merge workflows apply. Consider using the lint prompt after merges to catch inconsistencies.

---

## Related Projects

- [awesome-llm-knowledge-bases](https://github.com/SingggggYee/awesome-llm-knowledge-bases) -- Community resources for LLM-powered knowledge management
- [wiki-compiler](https://github.com/SingggggYee/wiki-compiler) -- CLI tool that automates this template's workflow
- [kb-lint](https://github.com/SingggggYee/kb-lint) -- Linter for your compiled wiki
- Obsidian -- [obsidian.md](https://obsidian.md) -- The recommended viewer for this template
- Marp -- [marp.app](https://marp.app) -- Slide deck renderer for the slides prompt output
- Mermaid -- [mermaid.js.org](https://mermaid.js.org) -- Diagram renderer for the visualize prompt output

---

## License

MIT. See [LICENSE](LICENSE).

---

Built on the idea that the best way to learn is to build a personal wiki. Inspired by Zettelkasten, digital gardens, and the emerging practice of using LLMs as knowledge compilers.
