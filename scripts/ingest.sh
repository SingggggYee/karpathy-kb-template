#!/usr/bin/env bash
#
# ingest.sh -- Copy a raw source file into the knowledge base and print next steps.
#
# Usage: ./scripts/ingest.sh <file_path> [optional_subdirectory]
# Example: ./scripts/ingest.sh ~/Downloads/attention-paper.pdf transformers

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RAW_DIR="$PROJECT_ROOT/raw"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <file_path> [subdirectory]"
    echo ""
    echo "Copy a source file into raw/ and get ingestion instructions."
    echo ""
    echo "Examples:"
    echo "  $0 ~/Downloads/paper.pdf"
    echo "  $0 ~/Downloads/paper.pdf transformers"
    exit 1
fi

SOURCE_FILE="$1"
SUBDIR="${2:-}"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: File not found: $SOURCE_FILE"
    exit 1
fi

FILENAME="$(basename "$SOURCE_FILE")"

if [ -n "$SUBDIR" ]; then
    DEST_DIR="$RAW_DIR/$SUBDIR"
    mkdir -p "$DEST_DIR"
else
    DEST_DIR="$RAW_DIR"
fi

DEST_PATH="$DEST_DIR/$FILENAME"

if [ -f "$DEST_PATH" ]; then
    echo "Warning: File already exists at $DEST_PATH"
    read -p "Overwrite? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

cp "$SOURCE_FILE" "$DEST_PATH"
echo "Copied: $SOURCE_FILE"
echo "    To: $DEST_PATH"
echo ""
echo "========================================="
echo "  Next Steps"
echo "========================================="
echo ""
echo "1. Open your LLM (Claude, GPT-4, etc.)"
echo "2. Paste the contents of prompts/ingest.md as your prompt"
echo "3. Attach or paste the contents of: $DEST_PATH"
echo "4. The LLM will create wiki articles in wiki/"
echo "5. Copy the generated files into your wiki/ directory"
echo "6. Open in Obsidian to browse and verify"
echo ""
echo "If using Claude Code:"
echo "  cat prompts/ingest.md && echo '---' && cat '$DEST_PATH'"
echo ""
