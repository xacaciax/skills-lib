# Personal Pi Skills Library

Custom skills for the [pi coding agent](https://github.com/earendil-works/pi-coding-agent) to automate job search research and outreach.

## Skills

### 🔍 company-research
Research companies using Brave Search API. Pulls company overview, recent news, tech stack, funding info, and key people.

**Usage:**
```bash
/skill:company-research "Company Name"
/skill:company-research "Company Name" "https://job-posting-url"
```

**Requirements:**
- Brave Search API key in `~/.zprofile` as `BRAVE_API_KEY`
- `brave-search` skill installed

### 📋 jd-analyzer
Analyze job descriptions from PDFs. Extracts requirements, matches to your experience, identifies gaps, and generates talking points.

**Usage:**
```bash
/skill:jd-analyzer ~/Downloads/job-posting.pdf
```

**Requirements:**
- Python with `pypdf` and `pdfplumber` packages
- `pdf` skill installed

### ✉️ outreach-generator
Generate personalized outreach messages (LinkedIn, email, informal) in your authentic voice. Reads writing samples to calibrate tone.

**Usage:**
```bash
/skill:outreach-generator "Recipient Name" "Company" "Context" ~/Downloads/research-file.md
```

**Requirements:**
- Writing samples in Apple Notes `[p] SWE Writing` folder (or customize the skill)
- Company research output as input

## Installation

1. Install pi coding agent: `npm install -g @earendil-works/pi-coding-agent`

2. Install required pi skills:
```bash
pi skill install github.com/badlogic/pi-skills/brave-search
pi skill install github.com/anthropics/skills/pdf
```

3. Clone this repo to your pi skills directory:
```bash
cd ~/.pi/agent/skills
git clone https://github.com/xacaciax/skills-lib.git
cd skills-lib
mv company-research jd-analyzer outreach-generator ..
```

4. Set up Brave Search API:
   - Get free API key at [brave.com/search/api](https://brave.com/search/api/)
   - Add to `~/.zprofile`: `export BRAVE_API_KEY="your-key-here"`
   - Run: `source ~/.zprofile`

5. Install Python dependencies:
```bash
pip install pypdf pdfplumber
```

## Customization

### outreach-generator Voice Calibration

By default, reads writing samples from Apple Notes `[p] SWE Writing` folder. To customize:

1. Edit `outreach-generator/generate.sh`
2. Update the `osascript` commands to point to your writing samples
3. Or replace with file-based samples

### Output Locations

Skills output to:
- `~/Downloads/` - Research files and message drafts
- Apple Notes `[p] Outreach SWE 400` (outreach-generator only, can be disabled)

Edit the skills to change output locations.

## Example Workflow

```bash
# 1. Analyze a job posting
/skill:jd-analyzer ~/Downloads/staff-swe-role.pdf

# 2. Research the company
/skill:company-research "Target Company" "https://job-url"

# 3. Generate outreach messages
/skill:outreach-generator "Hiring Manager" "Target Company" "applying for Staff SWE" ~/Downloads/research-target-company-*.md
```

## License

MIT License - See LICENSE file

## Author

Acacia Pappas | [GitHub](https://github.com/xacaciax)

---

Built with [pi coding agent](https://github.com/earendil-works/pi-coding-agent)
