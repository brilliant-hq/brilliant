#!/bin/bash
# Usage: get-element.sh <path-to-design-file> <element-id> [element-id-2 ...]
# Extracts the full YAML block for each requested element by ID.
FILE="$1"
shift
for ID in "$@"; do
  awk -v id="$ID" '
    $0 ~ "- id: " id { found=1 }
    found && /^  - id:/ && !($0 ~ "- id: " id) { found=0 }
    found { print }
  ' "$FILE"
  echo "---"
done
