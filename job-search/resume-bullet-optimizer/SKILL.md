---
name: "resume-bullet-optimizer"
description: "Research a person's actual work using connected Slack, Notion, and git/GitHub tools, then rewrite their resume bullets into up to 5 tightened variations optimized for MAANG (Meta/Amazon/Apple/Netflix/Google) recruiters. Use this skill WHENEVER the user wants to revise, improve, tighten, punch up, quantify, or \"make stronger\" one or more resume bullets, CV lines, LinkedIn accomplishments, or brag-doc entries — even if they don't say the word \"resume.\" Also trigger on requests like \"help me describe what I did on project X for my resume\" or \"make these sound more impressive for a big-tech application.\" Do NOT use for full resume layout/formatting, cover letters, or interview prep."
---

# Resume Bullet Optimizer

Turn raw or weak resume bullets into up to 5 sharp variations per bullet, grounded
in evidence pulled from the person's real work across Slack, Notion, and their
git/GitHub connector. The whole point is that a good MAANG bullet is *specific* and
*quantified* — and the fastest way to get specifics right is to go read what the
person actually shipped instead of guessing.

## When someone gives you 1–N bullets

Handle each bullet independently but research in batches where the work overlaps.
The flow for each bullet is: **understand → research → rewrite → present**.

If the user hasn't said who the bullets are about, assume it's them. If the bullets
clearly describe someone else (a report they're reviewing, a candidate), ask whose
work it is once, up front — the research only works if you know which person to look
up in the connectors.

## Step 1 — Understand the claim

Read each bullet and extract, in your own head:

- The **action** (what did they do — built, led, migrated, launched?)
- The **object/system** (what thing — a service, a pipeline, a team, a feature?)
- Any **stated scope or metric** (users, latency, revenue, headcount, %)
- The **implied timeframe** and likely project name / codename

These become your search terms. A bullet like *"Improved API performance"* gives you
the search seeds: the API/service name, "latency," "p99," "performance," plus the
person's name.

## Step 2 — Research the real scope and impact

This is where the leverage is. Use the connectors to find the concrete details that
make a bullet credible. Weight your effort roughly: **Slack and Notion first, git/GitHub
as supporting evidence.** In practice Slack threads and Notion docs describe *impact and
scope* (who used it, what it unblocked, what the numbers were), while git mostly
confirms *authorship and technical substance*.

**Slack** — search for the person and the project/system name. Look for:
- Launch announcements, demo threads, "shipped" / "rolled out" messages
- Metrics quoted in-channel ("cut build time from 40m to 9m," "handled 2M req/day")
- Praise, kudos, or leadership shout-outs that signal visibility and scope
- Incident or migration threads that show ownership and blast radius

**Notion** — search the person's name and project keywords. Look for:
- Project/PRD/design docs they authored or drove (scope, goals, success metrics)
- Retrospectives and postmortems (outcomes, before/after numbers)
- Roadmap or planning pages that show what they owned and who depended on it
- OKR / goal docs that tie the work to a business metric

**git / GitHub (supporting)** — use whichever git connector is live; it's usually
GitHub. Look for the person's PRs, commits, and issues on the relevant repos to
confirm they actually authored the work, gauge its technical weight (size, number of
services touched, review activity), and pin down timeframes. Treat this as
corroboration, not the headline — a big PR is evidence of substance but rarely
supplies the impact number a recruiter cares about.

Search each connector with a couple of query variations (person name, system name,
codename, key verb). If a connector returns nothing useful after a reasonable try,
move on — don't stall the whole bullet on one empty source. If none of the connectors
turn up anything for a bullet, say so plainly and rewrite from the bullet's own
content plus sensible assumptions.

Note the authorization state: if Slack, Notion, or the git connector aren't
authorized/connected in the session, tell the user which sources you couldn't reach
so they understand the evidence is thinner, then proceed with what you have.

## Step 3 — Rewrite for MAANG recruiters

MAANG recruiters and hiring committees skim fast and reward bullets that read as
**impact-first, quantified, and scoped**. Build each variation from this spine:

> **[Strong action verb] + [what you built/did] + [technical scope] + [quantified
> impact / business outcome]**

What makes a bullet land:

- **Lead with impact, not tasks.** "Cut checkout latency 38%, lifting conversion 2.1%"
  beats "Responsible for optimizing the checkout service."
- **Quantify.** Numbers are the single biggest signal. Scale (QPS, users, data
  volume, $), improvement (%, x, before→after), and scope (team size, # services)
  all count. Use real numbers from research wherever you found them.
- **Show ownership and altitude.** "Led," "drove," "owned end-to-end," "designed"
  signal seniority; reserve them for work the research actually supports.
- **Name the tech where it's a credible keyword** (the language, system, or scale)
  without turning the bullet into a tech-stack dump.
- **One idea per bullet, tight.** Aim for one line, ~1–2 clauses. Cut "responsible
  for," "helped to," "worked on," "various," and other filler.
- **Strong, varied verbs.** Architected, scaled, launched, migrated, automated,
  reduced, accelerated, spearheaded — not a wall of "Developed / Developed / Developed."

### Handling metrics you can't fully verify

Aim for numbers grounded in research. When the research doesn't hand you a hard
number but the work clearly had measurable impact, you may propose a **reasonable,
plausible estimate** so the bullet is complete — but make it obvious it needs
confirming. Wrap any unverified figure in brackets with a tag, e.g.
`reduced page load time by [~30% — VERIFY]` or `serving [~500K — VERIFY] daily users`.
Never present an invented number as if it were sourced. The goal is to give the person
a strong draft they can confirm or correct in seconds, not to fabricate a track record.

### The 5 variations

For each input bullet, produce **up to 5** distinct variations that genuinely differ
in angle, so the person can pick what fits their story:

1. **Impact-led** — leads with the outcome/metric.
2. **Scale-led** — foregrounds the size of the system/audience/data.
3. **Leadership/ownership-led** — emphasizes scope of responsibility and cross-team drive.
4. **Technical-depth-led** — highlights the hard engineering / design decision.
5. **Concise power line** — the tightest possible version, maximum signal per word.

If a bullet's evidence only supports two or three honest angles, return fewer rather
than padding with near-duplicates. Quality and distinctness beat hitting five.

## Step 4 — Present in chat

Return results in the conversation (no file needed unless asked). For each input
bullet use this structure:

```
Original: <the bullet as given>

What I found: <1–3 sentence synthesis of the evidence — the real scope/metrics,
with a note on which connector each key fact came from>

Variations:
1. <impact-led>
2. <scale-led>
3. <ownership-led>
4. <technical-depth-led>
5. <concise power line>

⚠️ To verify: <any [VERIFY]-tagged numbers or claims the person should confirm>
```

Keep the "What I found" honest and brief — it's there so the person trusts the
rewrite and knows which facts to double-check. When you cite something specific from
a connector (a Slack thread, a Notion doc, a PR), link it if the tool provides a URL,
so they can jump to the source.

After presenting, offer a quick next step: fold their picks into a clean block, adjust
seniority framing for a specific role/level, or research a bullet more deeply.

## Guardrails

- **Don't fabricate.** Every concrete claim should trace to research or be clearly
  tagged as an estimate to verify. Inflated bullets get caught in interviews.
- **Match the person's real seniority.** Don't upgrade an IC's contribution to
  "led the org" — recruiters and interviewers probe scope.
- **Respect privacy.** Pull only what's needed to substantiate the bullets; don't
  surface unrelated personal or confidential material you happen to find.
- **Stay evidence-first for Slack/Notion, corroboration-first for git.** That
  weighting reflects where the impact numbers actually live.
