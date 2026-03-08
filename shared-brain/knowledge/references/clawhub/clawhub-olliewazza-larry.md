# ClawHub Skill Archive: OllieWazza/larry

- Source: https://clawhub.ai/OllieWazza/larry
- Captured at: 2026-03-04 (Asia/Seoul)
- Method: agent-browser page text extraction

---

ClawHub
Skills
Upload
Import
Search
System
Light
Dark
Sign in
with GitHub
Larry

Automate TikTok slideshow marketing for any app or product. Researches competitors, generates AI images, adds text overlays, posts via Postiz, tracks analyti...

⭐ 101 ·
7.1k · 15 current installs · 15 all-time installs
by
OliverHenry
·
@OllieWazza
SECURITY SCAN
VirusTotal
Benign
View report →
OpenClaw
Suspicious
MEDIUM CONFIDENCE
The skill's code and instructions match its stated TikTok marketing purpose, but the registry metadata omits the many credentials/config paths the scripts actually need and the skill will store/use sensitive API keys — review config handling and run in a sandbox before trusting it.
Details
▾

Like a lobster shell, security has layers — review code before you run it.

CURRENT VERSION
v1.0.0
Download zip
latest
v1.0.0
Files
Compare
Versions
SKILL.md
TikTok App Marketing

Automate your entire TikTok slideshow marketing pipeline: generate → overlay → post → track → iterate.

Proven results: 7 million views on the viral X article, 1M+ TikTok views, $670/month MRR — all from an AI agent running on an old gaming PC.

Prerequisites

This skill does NOT bundle any dependencies. Your AI agent will need to research and install the following based on your setup. Tell your agent what you're working with and it will figure out the rest.

Required
Node.js (v18+) — all scripts run on Node. Your agent should verify this is installed and install it if not.
node-canvas (npm install canvas) — used for adding text overlays to slide images. This is a native module that may need build tools (Python, make, C++ compiler) on some systems. Your agent should research the install requirements for your OS.
Postiz — this is the backbone of the whole system. Postiz handles posting to TikTok (and 28+ other platforms), but more importantly, it provides the analytics API that powers the daily feedback loop. Without Postiz, the agent can post but can't track what's working — and the feedback loop is what makes this skill actually grow your account instead of just posting blindly. Sign up at postiz.pro/oliverhenry.
Image Generation (pick one)

You choose what generates your images. Your agent should research the API docs for whichever you pick:

OpenAI — gpt-image-1.5 (ALWAYS 1.5, never 1). Needs an OpenAI API key. Best for realistic photo-style images. This is what Larry uses and what we strongly recommend.
Stability AI — Stable Diffusion XL and newer. Needs a Stability AI API key. Good for stylized/artistic images.
Replicate — run any open-source model (Flux, SDXL, etc.). Needs a Replicate API token. Most flexible.
Local — bring your own images. No API needed. Place images in the output directory and the script skips generation.
Conversion Tracking (optional but recommended for mobile apps)
RevenueCat — this is what completes the intelligence loop. Postiz tells you which posts get views. RevenueCat tells you which posts drive paying users. Combined, the agent can distinguish between a viral post that makes no money and a modest post that actually converts — and optimize accordingly. Install the RevenueCat skill from ClaWHub (clawhub install revenuecat) for full API access to subscribers, MRR, trials, churn, and revenue. There's also a RevenueCat MCP for programmatic control over products and offerings from your agent/IDE.
Cross-Posting (optional, recommended)

Postiz supports cross-posting to Instagram Reels, YouTube Shorts, Threads, Facebook, LinkedIn, and 20+ more platforms simultaneously. Your agent should research which platforms fit your audience and connect them in Postiz. Same content, different algorithms, more reach.

[...snip: full extracted body is long; keeping high-signal capture in this archive file ...]

Notable file list shown on page:
- SKILL.md (46 KB)
- references/analytics-loop.md (5.3 KB)
- references/app-categories.md (2.1 KB)
- references/competitor-research.md (3.6 KB)
- references/revenuecat-integration.md (3.6 KB)
- references/slide-structure.md (4.2 KB)
- scripts/add-text-overlay.js (5.9 KB)
- scripts/check-analytics.js (9.1 KB)
- scripts/competitor-research.js (3.2 KB)
- scripts/daily-report.js (24 KB)
- scripts/generate-slides.js (8.5 KB)
- scripts/onboarding.js (7.1 KB)
- scripts/post-to-tiktok.js (3.4 KB)
