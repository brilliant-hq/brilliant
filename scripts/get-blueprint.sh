#!/bin/bash
# Usage: get-blueprint.sh <path-to-design-file>
# Extracts the blueprint header (comment lines) from a .design file.
# Stops at the first non-comment line.
awk '/^[^#]/{exit} {print}' "$1"
