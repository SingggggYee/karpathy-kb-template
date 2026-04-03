#!/usr/bin/env bash
#
# lint.sh -- Quick health check for the wiki directory.
#
# Checks for:
#   - Article counts by type
#   - Broken wiki-links (references to non-existent articles)
#   - Articles with no incoming backlinks
#   - Missing frontmatter fields
#
# Usage: ./scripts/lint.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
WIKI_DIR="$PROJECT_ROOT/wiki"

echo "========================================="
echo "  Wiki Health Check"
echo "========================================="
echo ""

# Count articles (excluding templates and index)
TOTAL=$(find "$WIKI_DIR" -name "*.md" -not -path "*/_templates/*" -not -name "_index.md" | wc -l | tr -d ' ')
CONCEPTS=$(find "$WIKI_DIR/concepts" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
SOURCES=$(find "$WIKI_DIR/sources" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
COMPARISONS=$(find "$WIKI_DIR/comparisons" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

echo "Article Counts:"
echo "  Total:       $TOTAL"
echo "  Concepts:    $CONCEPTS"
echo "  Sources:     $SOURCES"
echo "  Comparisons: $COMPARISONS"
echo ""

# Find all wiki-links [[...]] referenced across articles
echo "Link Analysis:"
ALL_LINKS=$(grep -roh '\[\[[^]]*\]\]' "$WIKI_DIR" 2>/dev/null | sort | uniq || true)

if [ -z "$ALL_LINKS" ]; then
    echo "  No wiki-links found."
else
    LINK_COUNT=$(echo "$ALL_LINKS" | wc -l | tr -d ' ')
    echo "  Total unique wiki-links: $LINK_COUNT"

    # Check for broken links
    BROKEN=0
    while IFS= read -r link; do
        # Extract the link text (remove [[ and ]])
        name=$(echo "$link" | sed 's/\[\[//;s/\]\]//')
        # Check if a matching .md file exists anywhere in wiki/
        if ! find "$WIKI_DIR" -name "${name}.md" -not -path "*/_templates/*" | grep -q .; then
            if [ "$BROKEN" -eq 0 ]; then
                echo ""
                echo "  Broken links (referenced but no article found):"
            fi
            echo "    - [[$name]]"
            BROKEN=$((BROKEN + 1))
        fi
    done <<< "$ALL_LINKS"

    if [ "$BROKEN" -eq 0 ]; then
        echo "  Broken links: 0"
    else
        echo ""
        echo "  Total broken links: $BROKEN"
    fi
fi

echo ""

# Find articles with no incoming backlinks
echo "Orphan Check:"
ORPHANS=0
for article in $(find "$WIKI_DIR" -name "*.md" -not -path "*/_templates/*" -not -name "_index.md"); do
    basename_no_ext=$(basename "$article" .md)
    # Check if any other file references this article
    if ! grep -rl "\[\[$basename_no_ext\]\]" "$WIKI_DIR" --include="*.md" 2>/dev/null | grep -v "$article" | grep -q .; then
        if [ "$ORPHANS" -eq 0 ]; then
            echo "  Articles with no incoming backlinks:"
        fi
        echo "    - $basename_no_ext"
        ORPHANS=$((ORPHANS + 1))
    fi
done

if [ "$ORPHANS" -eq 0 ]; then
    echo "  All articles have at least one incoming backlink."
else
    echo ""
    echo "  Total orphans: $ORPHANS"
fi

echo ""

# Check for missing frontmatter
echo "Frontmatter Check:"
MISSING_FM=0
for article in $(find "$WIKI_DIR" -name "*.md" -not -path "*/_templates/*" -not -name "_index.md"); do
    if ! head -1 "$article" | grep -q '^---'; then
        if [ "$MISSING_FM" -eq 0 ]; then
            echo "  Articles missing frontmatter:"
        fi
        echo "    - $(basename "$article" .md)"
        MISSING_FM=$((MISSING_FM + 1))
    fi
done

if [ "$MISSING_FM" -eq 0 ]; then
    echo "  All articles have frontmatter."
fi

echo ""
echo "========================================="
echo "  Done."
echo "========================================="
echo ""
echo "For a deeper analysis, run the lint prompt (prompts/lint.md) with your LLM."
