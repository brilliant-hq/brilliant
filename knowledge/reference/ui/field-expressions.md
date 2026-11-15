---
name: "knowledge-ui-field-expressions"
description: "What numeric fields accept: math expressions, natural-language words, percentages, and rounding."
assumes: reference/ui
---

# Field Expressions

Most numeric fields support: typing exact values, dragging left/right, arrow keys (Shift for larger steps, Alt for smaller).

**Math expressions:** Type any arithmetic expression and press Enter to evaluate:

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `200 * 2/3` |  | 133.33 |
| `(100 + 200) / 3` |  | 100 |
| `* 2/3` | 200 | 133.33 (operator prefix uses current value) |
| `+ 50` | 200 | 250 |
| `/ 3` | 200 | 66.67 |

**Natural language:** Type words and press Enter:

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `half` | 200 | 100 |
| `double` | 200 | 400 |
| `triple` | 200 | 600 |
| `quarter` | 200 | 50 |
| `third` | 200 | 66.67 |
| `golden` | 200 | 323.61 (golden ratio) |
| `2x` / `3x` / `0.5x` | 200 | 400 / 600 / 100 |

**Percentages:**

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `50%` | 200 | 100 (50% of current) |
| `+ 10%` | 200 | 220 (add 10%) |
| `- 25%` | 200 | 150 (subtract 25%) |
| `200 + 10%` |  | 220 |

**Rounding:**

| Input | Field had `203.7` | Result |
|-------|-------------------|--------|
| `round` | 203.7 | 204 |
| `round 8` | 203.7 | 200 (nearest multiple of 8) |
| `floor` | 203.7 | 203 |
| `ceil` | 203.2 | 204 |
