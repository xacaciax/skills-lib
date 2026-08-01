---
name: company-research
description: Deep research on a company for cold outreach. Pulls company overview, recent news, tech stack signals, funding info, and key people. Use when preparing to reach out to someone at a company.
---

# Company Research

Comprehensive company research for job applications and cold outreach.

## Usage

```bash
{baseDir}/research.sh "Company Name"
{baseDir}/research.sh "Company Name" "https://optional-job-posting-url.com"
```

## What It Does

1. **Company Overview** - Basic info, mission, size, stage
2. **Recent News** - Last 6 months of announcements, funding, partnerships
3. **Tech Stack Signals** - From GitHub org, job postings, engineering blog
4. **Key People** - Engineering leaders, hiring managers
5. **Talking Points** - Mission alignment, technical overlaps

## Output

Structured markdown research brief saved to:
- `~/Downloads/research-{company-name}-{date}.md`
- Also printed to stdout

## Example

```bash
{baseDir}/research.sh "Khan Academy"
```

Output includes:
- Company overview and mission
- Recent news and funding
- Tech stack from public sources
- Key engineering leaders
- Suggested talking points for outreach

## Requirements

- Brave Search skill configured (API key in `$BRAVE_API_KEY`)
- Internet connection

## Tips

- Add job posting URL as second argument to extract tech stack requirements
- Research is cached for 24 hours to avoid duplicate API calls
- Use output to personalize cold emails and LinkedIn messages
