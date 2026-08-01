#!/bin/bash
set -e

COMPANY_NAME="$1"
JOB_URL="${2:-}"

if [ -z "$COMPANY_NAME" ]; then
    echo "Usage: $0 \"Company Name\" [job-posting-url]"
    echo "Example: $0 \"Khan Academy\" \"https://jobs.lever.co/khanacademy/...\""
    exit 1
fi

if [ -z "$BRAVE_API_KEY" ]; then
    echo "Error: BRAVE_API_KEY not set"
    echo "Brave Search skill must be configured first"
    exit 1
fi

BRAVE_SEARCH_DIR="$HOME/.pi/agent/git/github.com/badlogic/pi-skills/brave-search"
if [ ! -f "$BRAVE_SEARCH_DIR/search.js" ]; then
    echo "Error: Brave Search skill not found"
    echo "Expected at: $BRAVE_SEARCH_DIR"
    exit 1
fi

# Sanitize company name for filename
SAFE_NAME=$(echo "$COMPANY_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
DATE=$(date +%Y%m%d)
OUTPUT_FILE="$HOME/Downloads/research-${SAFE_NAME}-${DATE}.md"

echo "Researching ${COMPANY_NAME}..."
echo ""

# Start building the report
cat > "$OUTPUT_FILE" << EOF
# ${COMPANY_NAME} Research
Generated: $(date +"%Y-%m-%d %H:%M")

---

EOF

# 1. Company Overview
echo "→ Searching for company overview..."
"$BRAVE_SEARCH_DIR/search.js" "${COMPANY_NAME} company overview mission" -n 3 >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 2. Recent News
echo "→ Searching for recent news..."
echo "## Recent News (Last 6 Months)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
"$BRAVE_SEARCH_DIR/search.js" "${COMPANY_NAME} news" --freshness pm -n 5 >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 3. Tech Stack
echo "→ Searching for tech stack..."
echo "## Tech Stack & Engineering" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
"$BRAVE_SEARCH_DIR/search.js" "${COMPANY_NAME} tech stack engineering blog" -n 3 >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"

# 4. GitHub org (if exists)
echo "→ Checking GitHub..."
GITHUB_SEARCH=$("$BRAVE_SEARCH_DIR/search.js" "github.com/${SAFE_NAME}" -n 1 2>/dev/null || echo "")
if echo "$GITHUB_SEARCH" | grep -q "github.com"; then
    echo "### GitHub Organization" >> "$OUTPUT_FILE"
    echo "$GITHUB_SEARCH" >> "$OUTPUT_FILE"
else
    echo "### GitHub Organization" >> "$OUTPUT_FILE"
    echo "No public GitHub organization found." >> "$OUTPUT_FILE"
fi

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 5. Funding & Size
echo "→ Searching for funding info..."
echo "## Funding & Growth" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
"$BRAVE_SEARCH_DIR/search.js" "${COMPANY_NAME} funding series valuation" -n 3 >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 6. Leadership
echo "→ Searching for engineering leaders..."
echo "## Engineering Leadership" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
"$BRAVE_SEARCH_DIR/search.js" "${COMPANY_NAME} VP engineering CTO" -n 3 >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 7. Job posting analysis (if provided)
if [ -n "$JOB_URL" ]; then
    echo "→ Analyzing job posting..."
    echo "## Job Posting Analysis" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "URL: ${JOB_URL}" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Try to extract content from job posting
    "$BRAVE_SEARCH_DIR/content.js" "$JOB_URL" >> "$OUTPUT_FILE" 2>/dev/null || echo "Could not extract job posting content." >> "$OUTPUT_FILE"
fi

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 8. Talking points section (template)
cat >> "$OUTPUT_FILE" << 'EOF'
## Talking Points for Outreach

### Mission Alignment
- [ ] TODO: What about their mission resonates with your background?
- [ ] TODO: Connection to your educator experience?

### Technical Overlaps
- [ ] TODO: What tech stack matches your experience?
- [ ] TODO: Similar problems you've solved?

### Personal Touches
- [ ] TODO: Individual's background, projects, or writing?
- [ ] TODO: Company culture or values that align?

### Your Differentiators
- [ ] Former educator turned engineer
- [ ] AI systems at scale (20K students)
- [ ] Platform infrastructure & K-12 compliance
- [ ] Mission-driven work

EOF

echo ""
echo "✓ Research complete!"
echo "Saved to: $OUTPUT_FILE"
echo ""

# Also print to stdout
cat "$OUTPUT_FILE"
