#!/bin/bash
set -e

JD_INPUT="$1"

if [ -z "$JD_INPUT" ]; then
    echo "Usage: $0 <job-description-file-or-url>"
    echo ""
    echo "Examples:"
    echo "  $0 ~/Downloads/staff-swe-stripe.pdf"
    echo "  $0 ~/Downloads/job-description.txt"
    echo "  $0 \"https://jobs.lever.co/stripe/...\""
    exit 1
fi

DATE=$(date +%Y%m%d)
PROMPT_FILE="$HOME/Downloads/jd-analysis-prompt-${DATE}.txt"

echo "Analyzing job description..."
echo ""

# Extract JD content based on input type
JD_CONTENT=""

if [[ "$JD_INPUT" =~ ^https?:// ]]; then
    # URL - use Brave Search content extractor if available
    echo "→ Extracting from URL..."
    BRAVE_CONTENT="$HOME/.pi/agent/git/github.com/badlogic/pi-skills/brave-search/content.js"
    if [ -f "$BRAVE_CONTENT" ]; then
        JD_CONTENT=$("$BRAVE_CONTENT" "$JD_INPUT" 2>/dev/null || echo "Could not extract from URL")
    else
        echo "Warning: Brave Search skill not found, cannot extract from URL"
        JD_CONTENT="URL provided: $JD_INPUT (manual extraction needed)"
    fi
elif [[ "$JD_INPUT" =~ \.pdf$ ]]; then
    # PDF file
    echo "→ Extracting from PDF..."
    if ! command -v python3 &> /dev/null; then
        echo "Error: python3 not found"
        exit 1
    fi
    
    JD_CONTENT=$(python3 << EOF
import pdfplumber
import sys

try:
    with pdfplumber.open("$JD_INPUT") as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text() + "\n"
        print(text)
except Exception as e:
    print(f"Error extracting PDF: {e}", file=sys.stderr)
    sys.exit(1)
EOF
)
elif [ -f "$JD_INPUT" ]; then
    # Text file
    echo "→ Reading text file..."
    JD_CONTENT=$(cat "$JD_INPUT")
else
    echo "Error: Invalid input. Provide a PDF file, text file, or URL"
    exit 1
fi

if [ -z "$JD_CONTENT" ]; then
    echo "Error: Could not extract job description content"
    exit 1
fi

# Load resume/profile for matching
echo "→ Loading your profile..."
YOUR_PROFILE=""

LINKEDIN_PDF="$HOME/Downloads/acacia linkedin prove.pdf"
if [ -f "$LINKEDIN_PDF" ]; then
    YOUR_PROFILE=$(python3 << EOF
import pdfplumber
try:
    with pdfplumber.open("$LINKEDIN_PDF") as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text() + "\n"
        print(text)
except:
    pass
EOF
)
fi

if [ -z "$YOUR_PROFILE" ]; then
    echo "Warning: Could not load your profile from $LINKEDIN_PDF"
    echo "Analysis will be less accurate"
    YOUR_PROFILE="Profile not available"
fi

# Build analysis prompt
cat > "$PROMPT_FILE" << EOF
Analyze this job description and match it to my experience.

JOB DESCRIPTION:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${JD_CONTENT}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MY BACKGROUND:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${YOUR_PROFILE}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

YOUR TASK:

Create a structured analysis with these sections:

## Role Summary
- Level (Junior/Mid/Senior/Staff/Principal)
- Team/Department
- Primary focus areas

## Must-Have Requirements
List each required qualification with match assessment:
✅ **Requirement text**
   → My experience: [specific match from my background]
   → Evidence: [concrete example or metric]

⚠️ **Requirement I partially meet**
   → My experience: [what I do have]
   → Gap: [what's missing]

❌ **Requirement I don't meet**
   → Gap: [clear statement of what's missing]

## Nice-to-Have Requirements
Same format as must-haves.

## Gap Analysis
For each gap identified:
- How significant is this gap?
- Can it be learned quickly?
- How should I frame it in conversation?
- What related experience do I have?

## Talking Points
4-6 specific examples I should highlight:
1. [Concrete accomplishment that matches key requirement]
2. [Unique angle from my background - educator turned engineer]
3. [Technical depth example with metrics]
4. [Mission alignment or culture fit]

## Red Flags
Identify any concerns:
- Unrealistic scope for the level
- Mismatched expectations
- Signs of burnout risk
- Unclear responsibilities

## Recommendation
- Strong fit / Moderate fit / Weak fit
- Should I apply? Why or why not?
- What's my strongest angle?

ANALYSIS RULES:
- Be honest about gaps - don't inflate my experience
- Use specific examples from my background, not generic claims
- Include metrics when available (20K students, 12 states, etc.)
- Flag my differentiator: former educator turned engineer
- Focus on transferable skills when exact match isn't there
EOF

echo "→ Prompt saved to: $PROMPT_FILE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "NEXT STEP: Feed this prompt to pi for analysis"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Run this command:"
echo ""
echo "  cat $PROMPT_FILE"
echo ""
echo "Then paste it into your pi session for analysis."
echo ""

cat "$PROMPT_FILE"
