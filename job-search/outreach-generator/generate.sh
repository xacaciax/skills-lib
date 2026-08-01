#!/bin/bash
set -e

RECIPIENT_NAME="$1"
COMPANY="$2"
CONTEXT="$3"
RESEARCH_FILE="${4:-}"

if [ -z "$RECIPIENT_NAME" ] || [ -z "$COMPANY" ] || [ -z "$CONTEXT" ]; then
    echo "Usage: $0 \"Recipient Name\" \"Company\" \"Context\" [research-file]"
    echo ""
    echo "Example:"
    echo "  $0 \"Amos Latteier\" \"Khan Academy\" \"no open roles but interested\""
    echo "  $0 \"Jane Doe\" \"Stripe\" \"applying for Staff SWE\" ~/Downloads/research-stripe-20260715.md"
    exit 1
fi

# Sanitize names for filenames
SAFE_RECIPIENT=$(echo "$RECIPIENT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
SAFE_COMPANY=$(echo "$COMPANY" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
DATE=$(date +%Y%m%d)

PROMPT_FILE="$HOME/Downloads/outreach-prompt-${SAFE_RECIPIENT}-${DATE}.txt"
OUTPUT_FILE="$HOME/Downloads/outreach-${SAFE_RECIPIENT}-${SAFE_COMPANY}-${DATE}.md"

echo "Generating outreach messages for ${RECIPIENT_NAME} at ${COMPANY}..."
echo ""

# Read writing samples from Apple Notes
echo "→ Reading writing samples from [p] SWE Writing..."
BIO=$(osascript -e 'tell application "Notes" to get body of note "BIO  hand written" of folder "[p] SWE Writing" of default account' 2>/dev/null | sed 's/<[^>]*>//g' || echo "")
AI_PHILOSOPHY=$(osascript -e 'tell application "Notes" to get body of note "Published: Our AI Philosophy" of folder "[p] SWE Writing" of default account' 2>/dev/null | sed 's/<[^>]*>//g' || echo "")
PROUD_PROJECT=$(osascript -e 'tell application "Notes" to get body of note "What project are you most proud of?" of folder "[p] SWE Writing" of default account' 2>/dev/null | sed 's/<[^>]*>//g' || echo "")

if [ -z "$BIO" ]; then
    echo "Warning: Could not read writing samples from [p] SWE Writing"
    echo "Messages will be less personalized"
fi

# Load research if provided
RESEARCH_CONTENT=""
if [ -n "$RESEARCH_FILE" ] && [ -f "$RESEARCH_FILE" ]; then
    echo "→ Loading company research..."
    RESEARCH_CONTENT=$(cat "$RESEARCH_FILE")
fi

# Build the generation prompt
cat > "$PROMPT_FILE" << EOF
I need you to draft cold outreach messages to ${RECIPIENT_NAME} at ${COMPANY}.

CONTEXT: ${CONTEXT}

WRITING SAMPLES (learn my voice from these):

=== BIO Sample ===
${BIO}

=== Technical Writing Sample ===
${AI_PHILOSOPHY}

=== Project Description Sample ===
${PROUD_PROJECT}

COMPANY RESEARCH:
${RESEARCH_CONTENT}

YOUR TASK:

Generate 3 outreach message versions:

1. **LinkedIn Message** (~150 words)
   - Lead with engineering credentials (Interim CTO, AI systems, platform work)
   - Include 1-2 concrete technical accomplishments with numbers
   - Reference their work or company if research available
   - End with clear ask (20-min chat or intro)
   - Use my authentic voice: direct, specific, no corporate fluff

2. **Email Version** (~250 words)
   - Subject line that opens with my hook (engineer + educator)
   - More room for context and story
   - 2-3 bullet points on what I bring
   - Personal touch from research
   - Same ask as LinkedIn

3. **Short/Informal** (~100 words)
   - For if we have a mutual connection
   - Very direct, casual tone
   - Skip the background, focus on the ask

VOICE GUIDELINES from my samples:
- Be direct and honest ("I know you don't have roles posted")
- Use concrete numbers and specifics
- Avoid buzzwords and corporate speak
- Show technical depth without being verbose
- Make it conversational, not formal
- Personal touches matter (reference their work)

REQUIRED FRAMING:
- I was a teacher for 6 years before engineering
- Currently interim CTO at Hope Street Group
- Built AI platform serving 20K+ students across 12 states
- Key tech: agentic AI, platform infrastructure, K-12 compliance
- Mission-driven: didn't leave education, changed how I serve students

Output each version with clear section headers.
EOF

echo "→ Prompt saved to: $PROMPT_FILE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "NEXT STEP: Feed this prompt to pi to generate messages"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Run this command in your pi session:"
echo ""
echo "  cat $PROMPT_FILE"
echo ""
echo "Then paste the output and pi will generate the messages."
echo ""
echo "Or manually copy the prompt from:"
echo "  $PROMPT_FILE"
echo ""

cat "$PROMPT_FILE"
