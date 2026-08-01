---
name: outreach-generator
description: Draft cold emails and LinkedIn messages in your authentic voice. Reads writing samples from Apple Notes [p] SWE Writing folder, uses company research, and generates personalized outreach. Use when preparing to contact someone at a company.
---

# Outreach Message Generator

Generate cold outreach messages that sound like you, not a template.

## Usage

```bash
{baseDir}/generate.sh "Recipient Name" "Company" "Context/Why reaching out" [research-file]
```

## Arguments

1. **Recipient Name** - Person you're reaching out to
2. **Company** - Their company name
3. **Context** - Why you're reaching out (e.g., "no open roles but interested")
4. **Research File** (optional) - Path to company research markdown (from company-research skill)

## What It Does

1. Reads your writing samples from `[p] SWE Writing` Apple Notes folder
2. Analyzes your voice, tone, and style patterns
3. Loads company research (if provided)
4. Generates 3 versions:
   - **LinkedIn message** (~150 words, engineering-first)
   - **Email** (~250 words, more detail)
   - **Informal** (~100 words, if you have a personal connection)

## Output

Saves to `~/Downloads/outreach-{name}-{company}-{date}.md` with all three versions.

Also creates a note in `[p] Outreach SWE 400` with:
- Contact info template
- All message versions
- Research notes
- Status tracking

## Example

```bash
# Basic usage
{baseDir}/generate.sh "Amos Latteier" "Khan Academy" "no open roles but want to connect"

# With research file
{baseDir}/generate.sh "Amos Latteier" "Khan Academy" "no open roles" ~/Downloads/research-khan-academy-20260715.md
```

## Voice Calibration

The generator learns from these notes in `[p] SWE Writing`:
- **BIO hand written** - Your authentic intro style
- **Published: Our AI Philosophy** - How you explain technical concepts
- **What project are you most proud of?** - How you describe your work

To improve output quality:
- Add more writing samples to `[p] SWE Writing`
- Review generated drafts and save your edits back to Notes
- The more examples, the better it matches your voice

## Output Format

Each outreach note includes:
- Contact information (name, company, LinkedIn, email guesses)
- Status tracking (Draft → Sent → Response)
- Message versions (LinkedIn, Email, Informal)
- Research notes and talking points
- Personal touches identified from research

## Tips

- Use company-research skill first to gather talking points
- Include specific personal touches in the context arg
- Generated messages are starting points - always personalize
- Check [p] Outreach SWE 400 folder for your draft before sending
