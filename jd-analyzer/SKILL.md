---
name: jd-analyzer
description: Analyze job descriptions to extract requirements, identify gaps, and match to your experience. Outputs structured analysis with must-haves, nice-to-haves, gaps, and talking points. Use when evaluating whether to apply for a role.
---

# Job Description Analyzer

Extract requirements from job postings and match them to your background.

## Usage

```bash
{baseDir}/analyze.sh /path/to/job-description.pdf
{baseDir}/analyze.sh /path/to/job-description.txt
{baseDir}/analyze.sh "https://job-posting-url.com"
```

## What It Does

1. **Extracts** requirements from JD (PDF, text, or URL)
2. **Categorizes** into must-haves vs nice-to-haves
3. **Matches** to your resume and experience
4. **Identifies** gaps and how to address them
5. **Generates** talking points for cover letter/interview

## Output

Structured markdown analysis saved to:
- `~/Downloads/jd-analysis-{company}-{date}.md`

Includes:
- Role summary (level, team, focus)
- Must-have requirements (with your matches)
- Nice-to-have requirements (with your matches)
- Gap analysis (what you're missing and how to frame it)
- Talking points (specific examples to highlight)
- Red flags (unrealistic expectations, scope creep)

## Example

```bash
{baseDir}/analyze.sh ~/Downloads/staff-swe-stripe.pdf
```

Output:
```markdown
# Staff Software Engineer - Stripe

## Role Summary
- Level: Staff (L5/L6 equivalent)
- Team: Platform Infrastructure
- Focus: AI/ML infrastructure, developer productivity

## Must-Haves ✅ You Have
✅ **5+ years software engineering**
   → Your experience: 7+ years (2019-present)

✅ **AI/ML systems experience**
   → Your experience: Built agentic AI advisor serving 20K students
   → Evidence: Batch evaluation systems, real-time analytics

✅ **Platform/infrastructure work**
   → Your experience: Owned architecture at HSG
   → Evidence: RLS, PII-safe views, compliance for K-12

## Nice-to-Haves
✅ **EdTech or consumer product**
   → Your experience: 2.5 years EdTech + 6 years teaching

⚠️ **Stripe API experience**
   → Gap: No direct experience, but similar payment integrations

## Gaps & How to Address
⚠️ **Scale: Millions of users vs 20K students**
   Frame as: "Different scale, same infrastructure challenges"
   Talking point: "Built for growth - architecture supports 100x current load"

⚠️ **Public cloud: They use AWS, you use GCP at HSG**
   Frame as: "Cloud-agnostic - core concepts transfer"
   Talking point: "Worked with both AWS and GCP in previous roles"

## Talking Points
1. "Built AI systems similar to your ML platform at smaller scale"
2. "Platform infrastructure experience directly transferable"
3. "Educator background = unique perspective on developer experience"
4. "Mission-driven engineering - care about impact not just code"

## Red Flags
None detected.
```

## Resume Matching

The analyzer automatically references:
- Your LinkedIn profile (`~/Downloads/acacia linkedin prove.pdf`)
- Saved resume (if at `~/Documents/resume.pdf`)

Update these files to improve matching accuracy.

## Tips

- Run this before company research to understand what to research
- Use talking points in your outreach messages
- Gap analysis helps you prepare honest answers for screens
- Red flags might indicate roles to skip (unrealistic scope, burnout risk)
