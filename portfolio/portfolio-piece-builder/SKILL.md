---
name: portfolio-piece-builder
description: >-
  Turns a rough draft, sketch, or outline of a personal portfolio piece into a
  polished article by first researching real context from connected tools
  (Slack, Notion, and others), then proposing outline options before writing.
  Use this whenever the user brings a portfolio piece, portfolio article, case
  study, project writeup, reflective essay, or thought-leadership post they want
  to develop — especially when they hand over a draft or outline and want it
  "fleshed out," "researched," "colored in," or "turned into a real piece." Also
  trigger when the user says things like "help me write up this project,"
  "expand this portfolio outline," or "I sketched a piece, can you dig up
  context and draft it." Do not use for generic blog posts unrelated to the
  user's own work, or for internal company comms.
---

# Portfolio Piece Builder

This skill helps develop a personal portfolio piece from a rough seed (a draft,
a sketch, a bullet outline, or even a paragraph of intent) into a finished
article. The distinctive move is that it does not jump straight to prose. First
it goes and finds real, specific context from the user's connected tools — the
actual Slack threads, Notion docs, and other traces of the work being written
about — so the finished piece is grounded in what really happened rather than
generic filler. Then it offers the user a choice of angles before committing to
a draft.

The reason for this shape is that portfolio pieces live or die on specificity.
A writeup that says "I improved system reliability" is forgettable; one that
says "I traced a 3am pager storm to a retry loop and the fix cut on-call pages
40%" is memorable — and those details are sitting in Slack and Notion, not in
the user's head at drafting time. This skill's job is to surface them.

## The workflow

Follow these phases in order. The pause after phase 4 is the most important part
of the whole skill — do not skip it.

### 1. Understand the seed and the goal

Read whatever the user provided closely. Identify:

- **What the piece is about** — the project, decision, insight, or story at its
  core.
- **Piece type** — a project writeup, a technical case study, a
  narrative/reflective essay, or a thought-leadership post. These have different
  centers of gravity (see "Piece types" below), so name which one this is.
- **What's already there vs. what's thin** — which claims are asserted but
  unsupported, which moments are gestured at but not shown, where the piece
  needs evidence or color.

If the goal or audience is genuinely unclear and it would change the research
direction, ask one focused question. Otherwise infer sensibly and proceed —
the user came here to make progress, not to fill out a form.

**Ask for a writing sample.** At this stage, ask the user whether they have a
past piece written in their own voice — ideally one in the same register as this
one (a portfolio essay or writeup, not a Slack message) — that they can share as
a style reference. Explain briefly why: voice is far easier for you to imitate
from a real example than to reconstruct from a description, so a single sample
makes the final draft sound like them rather than like generic AI prose. If they
share one, study it for how they open and close, sentence rhythm, diction,
punctuation habits (em dashes, semicolons), how much they hedge, and any words
they clearly favor or avoid — and hold those patterns for phase 5. If they don't
have one, that's fine; proceed and match voice as best you can from the seed
they provided.

### 2. Research for context

Mine the user's connected tools for material that could enrich the piece. The
point is to find the concrete, quotable, specific things the user would want to
reference but won't remember verbatim: dates, metrics, decisions, turning
points, direct quotes, what other people said, what the problem actually looked
like before it was solved.

Search broadly, then read what looks promising:

- **Slack** — search for the project name, feature names, people involved, and
  the rough time window. Look for the messy real story: the moment something
  broke, a debate about tradeoffs, a customer or teammate reaction, a "finally
  works" celebration. Read threads, not just isolated messages.
- **Notion** — search for design docs, PRDs, retros, planning notes, and
  meeting notes tied to the work. These give the structured backbone (goals,
  decisions, outcomes) that Slack won't.
- **Other connectors as they fit** — if the user has a wiki, project tracker
  (Linear/Asana/ClickUp/Jira), Google Drive/Box, meeting notes (Granola/Fireflies),
  or analytics, and they're relevant to this piece, pull from them too. Use
  judgment; don't force irrelevant sources.

Cast a reasonably wide net — run several searches with different terms, since
the useful thread is often filed under a name you didn't guess first. If a
connector the piece clearly needs isn't authorized or returns nothing, note
that briefly rather than stalling.

### 3. Build a research index

Present, **in chat**, an organized index of what you found. This is a working
artifact, not the article — its job is to let the user see the raw material and
say "oh yes, use that" or "no, that's off." Organize it so it's scannable:

Group findings thematically (e.g., "The original problem," "Key decisions,"
"Metrics & outcomes," "Memorable moments/quotes," "Other voices"). For each
finding, give a one-line summary of the substance plus where it came from, and
link the source when the tool provides a URL so the user can click through.
Flag the few items you think are the strongest raw material for the piece.

Keep it tight — a useful index surfaces the signal, it doesn't transcribe
everything.

**Flag conflicts, don't resolve them silently.** Research routinely turns up
facts that disagree — the seed says 200 students, a doc says 800; one source
calls the product by an old name, another by its rename; two places give
different headline metrics. When a source contradicts the user's own draft or
another source on something that will appear in the piece (numbers, names,
dates, claims), surface it explicitly in the index as a conflict: show both
values, name where each came from, and ask the user which is canonical rather
than quietly picking one. This matters because the user is the only one who
knows which version is true, and a confidently-stated wrong number in a
portfolio piece is worse than no number — it's the kind of thing a reader (or
interviewer) catches. If you must draft before the user has arbitrated, write
around the conflict with softer phrasing and mark it, rather than committing to
a figure you can't stand behind.

### 4. Sketch three outline variations — then STOP

Propose **three distinct high-level outlines** for the piece, in chat. These are
angles, not just section lists — each should represent a genuinely different way
to tell this story, so the user has a real choice rather than three flavors of
the same thing. For example one might lead with the technical problem, another
with a narrative/personal arc, another with the broader lesson or thesis.

For each variation give: a short name, a one-sentence description of the angle
and why it might work, and a high-level bullet skeleton of the sections (not
full prose). Note which pieces of the research index each outline would lean on.

Then **stop and wait for the user to choose.** Do not begin drafting. This pause
exists because the angle is the highest-leverage decision in the whole piece,
and it's cheap for the user to redirect now and expensive to rewrite a full
draft later. Invite them to pick one, mix elements across them, or push back.

### 5. Draft the chosen piece

Once the user confirms an outline (or a blend), write the full draft, weaving in
the specific context you surfaced in phase 2. This is where the research pays
off: use the real metrics, quotes, dates, and moments rather than generic
stand-ins. Match the voice to the piece type and to how the user writes.

Match the user's voice. If they shared a writing sample in phase 1, mirror the
patterns you noted from it — their openers, rhythm, diction, and punctuation
habits — rather than defaulting to generic prose. Steer away from the usual AI
tells (reflexive hedging, tidy three-item lists, words like "delve" or
"moreover," inflated claims). If no sample was provided, write in a clear,
first-person, grounded voice — confident but not inflated, specific over
sweeping — and note that sharing a sample next time would sharpen the match.

Save the final draft as a Markdown file and present it to the user. (Per the
user's preference, only the final draft becomes a file — the research index and
outlines stay in chat.) Offer to revise.

## Piece types

Let the type steer emphasis, not a rigid template:

- **Project writeup** — shortest form. What it was, why it mattered, what you
  did, the impact. Lead with outcome; keep it skimmable.
- **Technical case study** — the deepest. Problem, constraints, approaches
  considered, the tradeoffs, what you built, results, what you'd do differently.
  Show your reasoning; this is where surfaced technical detail matters most.
- **Narrative / reflective essay** — first-person arc. A specific moment or
  struggle, what changed, what you learned. Color and honesty over
  completeness.
- **Thought-leadership post** — leads with a point of view. Uses the specific
  work as evidence for a broader claim about the domain. Earn the thesis with
  concrete detail rather than asserting it.

## Notes

- The pause in phase 4 is non-negotiable — the whole value of offering three
  angles evaporates if you barrel past it into a draft.
- Ground claims in what you actually found. If the research doesn't support a
  flattering framing, tell the user rather than inventing detail — a portfolio
  piece that overstates is worse than one that's modest and true.
- Grounding a story in concrete scale and scope — real numbers, dates, named
  partners — is usually what separates a memorable piece from a vague one, so
  actively look for those figures during research and work them in. But every
  number must trace to a source, and any that conflict must be arbitrated by the
  user first (see phase 3).
- Respect that this is the user's personal work and voice. You're surfacing
  their story and giving them options, not authoring their reputation for them.
