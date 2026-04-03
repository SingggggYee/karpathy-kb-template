# Output

This directory holds generated artifacts derived from your wiki. These are produced by running the compile, slides, and visualize prompts against your wiki content.

## Output Types

| Type | Prompt | Description |
|------|--------|-------------|
| `slides/` | `prompts/slides.md` | Marp-compatible slide decks |
| `reports/` | `prompts/compile.md` | Compiled topic reports and summaries |
| `visuals/` | `prompts/visualize.md` | Mermaid diagrams, concept maps, timelines |
| `exports/` | manual | PDF/HTML exports from Obsidian |

## Notes

- Output files are **derived artifacts** -- they can always be regenerated from the wiki
- Consider adding `output/` to `.gitignore` if you prefer not to track generated files
- Slide decks use [Marp](https://marp.app/) format and can be rendered with the Marp CLI or VS Code extension
- Mermaid diagrams can be rendered in Obsidian, GitHub, or with the Mermaid CLI
