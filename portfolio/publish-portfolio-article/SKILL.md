---
name: publish-portfolio-article
description: >-
  Formats article text for xacaciax.github.io and generates the complete ARTICLES
  array entry with proper HTML formatting. Applies site-specific patterns: timeline
  entries with line breaks, stat callouts in styled divs, pull quotes in blockquotes,
  and breaks up dense paragraphs for web readability. Use whenever the user wants to
  publish an article, blog post, or writeup to their portfolio site. Handles plain
  text or markdown input, preserves the author's voice exactly, and outputs
  production-ready HTML following established site conventions.
---

# Publish Portfolio Article

This skill transforms article text into a properly formatted ARTICLES array entry
for xacaciax.github.io, following the site's established formatting patterns.

## What it does

Takes raw article text (plain text or markdown) and:

1. **Preserves author voice** — zero changes to content, only formatting
2. **Applies site patterns** — timeline breaks, stat callouts, pull quotes
3. **Generates metadata** — id, title, subtitle, date, tags, section
4. **Outputs ready-to-paste** — complete ARTICLES object for index.html

## The workflow

### 1. Collect article metadata

Ask the user for:
- **Title** — the article headline
- **Subtitle** (optional) — one-sentence description
- **Date** — display string (e.g., "August 2026")
- **Date ISO** — machine-readable (e.g., "2026-08-01")
- **Section** — "now", "recently", or "archive"
- **Tags** — array of keywords (e.g., ["AI", "EdTech", "product"])
- **Image** (optional) — {src: "path", alt: "description"}

If the user provides article text with a clear title at the top, use that and ask
only what's missing. Don't make the user fill out a form.

### 2. Parse and structure the article

Read through the provided text and identify:
- **Section headings** — will become `<h2>` tags
- **Timeline markers** — date-prefixed lines like "Nov 2022 — Event name"
- **Dense paragraphs** — anything over ~100 words
- **Quotable insights** — key sentences that would work as pull quotes
- **Embedded stats** — numbers with context (percentages, counts, metrics)

### 3. Apply xacaciax.github.io formatting patterns

Transform the text using these established site conventions:

#### **Pattern 1: Timeline entries with `<br>`**

For chronological markers (dates + event descriptions):

**Input:**
```
Nov 2022 — ChatGPT (GPT-3.5). A million users in five days.
```

**Output:**
```html
<p><strong>Nov 2022</strong> — ChatGPT (GPT-3.5)<br>
A million users in five days.</p>
```

Split the description onto a new line after the event name. Makes timeline scanning easier.

#### **Pattern 2: Stat callouts with `<div class="stat-line">`**

When a paragraph embeds multiple metrics, extract them into a visual callout:

**Input:**
```
The signals were loud: 46% opened outside class, 76% retention, and 200 students.
```

**Output:**
```html
<p>The signals were loud:</p>

<div class="stat-line">
  <span><strong>46%</strong> opened outside class</span>
  <span><strong>76%</strong> retention</span>
  <span><strong>200</strong> students</span>
</div>
```

Guidelines:
- Extract 2-4 related metrics
- Use `<strong>` for the number
- Brief label after the number
- Rewrite surrounding prose if needed to introduce the callout

#### **Pattern 3: Pull quotes with `<blockquote>`**

Extract 2-4 memorable sentences as pull quotes. Good candidates:
- Key insights or turning points
- Thesis statements
- Memorable phrasing
- Design decisions or principles

**Input:**
```
The gap wasn't the opportunity, it was knowing how to turn the in-person meeting into something valuable.
```

**Output:**
```html
<blockquote>The gap wasn't the opportunity, it was knowing how to turn the in-person meeting into something valuable for their own future goals.</blockquote>
```

Pull the sentence out of its paragraph and render it standalone. The original
paragraph can introduce it or flow past it.

#### **Pattern 4: Break up dense paragraphs**

Split paragraphs over ~100 words at natural thought boundaries:

**Input:**
```
The most exciting thing about the app was the breadth. It was a career fair in your pocket. But the classroom runs exposed the seams. Onboarding times were wildly inconsistent. And students immediately probed the limits. We added a moderation layer. There was real debate about what inappropriate means. We ended up letting school norms set the line.
```

**Output:**
```html
<p>The most exciting thing about the app was the breadth. It was a career fair in your pocket, available any time you needed it.</p>

<p>But the classroom runs exposed the seams. Onboarding times were wildly inconsistent — some students moved through the form in a minute, others took fifteen. And students, being students, immediately probed the limits of character generation, asking for the most inappropriate careers they could invent.</p>

<p>We added a moderation layer that ran against every completion and intercepted requests that weren't school-appropriate. There was real internal debate about what inappropriate even means for a job; we ended up letting the broader norms of schools set the line.</p>
```

Split at shifts in topic or tone. Shorter paragraphs scan better on mobile.

#### **Pattern 5: Standard HTML for everything else**

- Section headings → `<h2>Heading</h2>`
- Regular paragraphs → `<p>Text</p>`
- First paragraph → `<p class="article-summary">Summary text</p>`
- Em dashes → `&mdash;`
- Inline emphasis → `<em>italic</em>` or `<strong>bold</strong>`
- Links → `<a href="url" target="_blank" rel="noopener">text</a>`

### 4. Generate the ARTICLES entry

Build the complete object:

```javascript
{
  id:       "kebab-case-slug",
  title:    "Article Title",
  subtitle: "One-sentence description",
  date:     "August 2026",
  dateISO:  "2026-08-01",
  section:  "now",  // or "recently" or "archive"
  tags:     ["tag1", "tag2", "tag3"],
  image:    null,  // or { src: "path/to/image.jpg", alt: "description" }
  body: `
    <p class="article-summary">Opening summary paragraph.</p>

    <p>First body paragraph...</p>

    <h2>Section Heading</h2>

    <p><strong>Nov 2022</strong> — Event<br>
    Description continues here.</p>

    <div class="stat-line">
      <span><strong>46%</strong> metric one</span>
      <span><strong>76%</strong> metric two</span>
    </div>

    <blockquote>Key insight as pull quote.</blockquote>

    <p>Continued narrative...</p>
  `
},
```

### 5. Output in chat

Present the complete ARTICLES entry as a code block, ready to paste into
index.html. Add a summary showing:
- Character count of the body
- Number of stat callouts added
- Number of pull quotes added
- Number of paragraphs (original → reformatted)

Then offer to:
- Adjust any formatting choices
- Generate updated llms.txt entry
- Generate updated humans.txt and sitemap.xml dates

## Guidelines

### Voice preservation is non-negotiable

The user's exact words stay unchanged. You are reformatting for readability, not
rewriting for style. If you need to adjust a sentence to make a stat callout work,
show the user the change and confirm.

### Pattern application is judgment, not formula

Not every article needs every pattern. Use:
- Timeline breaks only if the article is chronological
- Stat callouts only when 2+ metrics cluster naturally
- Pull quotes only for genuinely quotable insights (2-4 per article)
- Paragraph breaks where they improve flow

If forcing a pattern makes the text worse, skip it.

### Match the site's existing articles

The site has three published articles:
1. "From Educator to Engineer" (2019) — narrative essay, 1 stat callout, 1 pull quote
2. "Building Reliable Applications..." (2024) — technical talk, 2 stat callouts, no pull quotes
3. "Scaling Hope AI" (2026) — chronological build story, 3 stat callouts, 4 pull quotes, timeline breaks

Let the content type guide the patterns. Narrative essays and chronological build
stories benefit from pull quotes. Technical writeups lean on stat callouts. Not every
article uses timeline breaks.

### IDs, tags, and slugs

- **ID** — kebab-case, derived from title, unique across all articles
- **Tags** — short keywords (2-8), lowercase, match existing tags where relevant
  (check existing articles for tag vocabulary)
- **Section** — "now" for current work, "recently" for completed work still fresh,
  "archive" for older pieces

### Images

If the user provides an image, store it in `assets/articles/` with a descriptive
filename (e.g., `chatgpt_usage_2025.png`). Reference it as:

```javascript
image: { src: "assets/articles/filename.jpg", alt: "Descriptive alt text" }
```

If no image, set `image: null`.

## Notes

- This skill formats for one specific site (xacaciax.github.io). It won't work
  generically across other portfolio sites without adaptation.
- The formatting patterns evolved from analyzing what works for long-form technical
  and narrative writing on the web: scannability, visual rhythm, mobile readability.
- If the user wants different formatting (more pull quotes, different stat styling),
  respect that — the patterns are defaults, not rules.
- The skill does NOT edit index.html directly. It generates the entry; the user
  pastes it in.
