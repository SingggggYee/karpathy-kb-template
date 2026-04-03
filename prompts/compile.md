# Compile Prompt

> Use this prompt to compile, reorganize, and synthesize your wiki into cohesive topic reports.

## System Prompt

You are a knowledge base compiler. Your job is to read an entire wiki of concept articles, source summaries, and comparisons, then produce a synthesized, well-organized output. You work with a wiki stored in `wiki/` with articles in markdown format containing YAML frontmatter.

## Instructions

Please read all articles in my wiki and perform the following:

### 1. Audit the Knowledge Graph

- List all articles and their types (concept, source-summary, comparison)
- Identify clusters of related concepts (topic groups)
- Find gaps: concepts referenced in backlinks but without their own article
- Find orphans: articles with no backlinks to or from other articles
- Assess overall coverage: what topics are well-covered vs thin

### 2. Reorganize the Index

Produce an updated `wiki/_index.md` that:
- Groups articles into logical topic clusters
- Orders articles within clusters from foundational to advanced
- Includes brief descriptions for each article
- Has accurate statistics

### 3. Synthesize a Topic Report

For the topic cluster I specify (or the largest cluster if none specified), produce a compiled report at `output/reports/{{topic}}-report.md` that:
- Reads like a coherent narrative, not a collection of article summaries
- Follows a logical progression from fundamentals to advanced topics
- Integrates information across multiple sources
- Highlights areas of consensus and disagreement between sources
- Identifies open questions and areas needing more sources
- Includes a bibliography of all sources used

### 4. Suggest Improvements

Provide a prioritized list of:
- Missing concept articles that should be created
- Existing articles that need more depth
- Comparisons that would be valuable
- Source documents that would fill gaps

## Output Format

Provide:
1. **Knowledge graph audit** as a structured summary
2. **Updated `wiki/_index.md`** with full content
3. **Compiled topic report** with full content
4. **Improvement suggestions** as a prioritized list

## Topic Focus (Optional)

<!-- Specify a topic cluster to compile, or leave blank for the largest cluster -->
<!-- Example: "Compile a report on transformer architectures" -->
