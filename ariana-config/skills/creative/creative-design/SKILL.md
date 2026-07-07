---
name: creative-design
description: "Creative content generation — visual design, diagrams, ASCII art, animation, music, and AI-powered creative workflows. Use when the user wants to create visual art, design artifacts, generate music, produce animations, or any creative output."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [creative, design, visual, art, animation, music, generative, ascii, diagram, prototype]
    related_skills: [claude-design, architecture-diagram, ascii-art, ascii-video, baoyu-infographic, design-md, excalidraw, humanizer, manim-video, p5js, popular-web-designs, pretext, sketch, songwriting-and-ai-music]
---

# Creative Design — Umbrella Skill

This is the umbrella skill for all creative content generation. It provides a decision tree to route to the right sub-skill, plus shared creative standards.

## When to Use

Use this skill when the user wants to create:
- Visual art, diagrams, or infographics
- ASCII art or text-based visuals
- Animations or video content
- Music or audio content
- Web design mockups or prototypes
- Hand-drawn style diagrams
- Humanized/rewritten text

## Decision Tree

### What is the creative output?

| Output Type | Sub-Skill | Trigger Keywords |
|---|---|---|
| Architecture/cloud diagrams (SVG/HTML) | `architecture-diagram` | architecture diagram, cloud diagram, infra diagram, system design |
| ASCII art from text | `ascii-art` | ascii art, text banner, pyfiglet, cowsay, boxes |
| ASCII video from media | `ascii-video` | ascii video, text art video, terminal video, character animation |
| Infographics (21×21 layouts) | `baoyu-infographic` | infographic, 信息图, visual summary, high-density info |
| One-off HTML design artifacts | `claude-design` | landing page, prototype, deck, mockup, design artifact |
| DESIGN.md token specs | `design-md` | design tokens, DESIGN.md, design system spec |
| Hand-drawn diagrams (JSON) | `excalidraw` | excalidraw, hand-drawn diagram, flowchart, sequence diagram |
| Humanize AI text | `humanizer` | humanize, de-AI, de-slop, un-ChatGPT, rewrite |
| Math/algorithm animations | `manim-video` | manim, 3Blue1Brown, math animation, algorithm visualization |
| Generative art (p5.js) | `p5js` | p5.js, generative art, creative coding, canvas, shader |
| Real-world design systems | `popular-web-designs` | design like Stripe/Linear/Vercel, design system, CSS template |
| Text layout demos | `pretext` | pretext, text-as-geometry, kinetic typography, text reflow |
| Throwaway HTML mockups | `sketch` | sketch, mockup, variant comparison, wireframe |
| Songwriting & AI music | `songwriting-and-ai-music` | song, lyrics, suno, music prompt, parody |

## Sub-Skill Quick Reference

### Visual Design & Diagrams

#### architecture-diagram
Dark-themed SVG architecture/cloud/infra diagrams as standalone HTML. No external dependencies.
- **Output:** Single `.html` file with inline SVG
- **Color palette:** Semantic mapping (frontend=cyan, backend=emerald, database=violet, etc.)
- **Template:** `skill_view(name="architecture-diagram", file_path="templates/template.html")`

#### excalidraw
Hand-drawn style diagrams as `.excalidraw` JSON files. Opens at excalidraw.com.
- **Output:** `.excalidraw` file
- **Element types:** rectangle, ellipse, diamond, arrow, text
- **Container binding:** Use `boundElements` + `containerId` for labeled shapes

#### popular-web-designs
54 real-world design systems (Stripe, Linear, Vercel, etc.) as HTML/CSS templates.
- **Output:** Design token reference + HTML/CSS
- **54 templates** across AI/ML, dev tools, infrastructure, fintech, enterprise
- **Load:** `skill_view(name="popular-web-designs", file_path="templates/<site>.md")`

#### design-md
Google's DESIGN.md token spec format for design systems.
- **Output:** `DESIGN.md` file with YAML frontmatter + markdown body
- **CLI:** `npx @google/design.md lint/export/diff`
- **Template:** `skill_view(name="design-md", file_path="templates/starter.md")`

#### baoyu-infographic
Infographic generator with 21 layouts × 21 styles.
- **Output:** `infographic.png` + supporting files
- **Workflow:** Analyze → Structure → Generate prompt → Generate image
- **Keyword shortcuts:** "高密度信息大图" → dense-modules layout

### ASCII & Text Art

#### ascii-art
Multiple tools: pyfiglet (text banners), cowsay (message art), boxes (borders), image-to-ASCII.
- **Text banners:** `python3 -m pyfiglet "TEXT" -f slant`
- **Cowsay:** `cowsay "message"`
- **Image conversion:** `ascii-image-converter image.png`
- **Pre-made art:** ascii.co.uk via curl

#### ascii-video
Convert video/audio to colored ASCII character video (MP4/GIF).
- **Stack:** Python + NumPy + SciPy + Pillow + ffmpeg
- **Modes:** Video-to-ASCII, audio-reactive, generative, hybrid, lyrics
- **References:** `references/architecture.md`, `references/effects.md`, `references/shaders.md`

### Animation & Video

#### manim-video
3Blue1Brown-style math/algorithm animations using Manim CE.
- **Stack:** Manim CE + LaTeX + ffmpeg
- **Modes:** Concept explainer, equation derivation, algorithm visualization, data story, 3D
- **References:** `references/animations.md`, `references/scene-planning.md`

#### p5js
Generative art, interactive visualizations, and creative coding with p5.js.
- **Output:** Single self-contained HTML file
- **Modes:** Generative art, data viz, interactive, animation, 3D, audio-reactive
- **References:** `references/core-api.md`, `references/visual-effects.md`

### Design Process

#### claude-design
Design process and taste for one-off HTML artifacts (landing pages, decks, prototypes).
- **Output:** Self-contained HTML file with inline CSS/JS
- **Process:** Brief → Context → Design system → Build → Verify
- **Anti-slop rules:** No generic SaaS layouts, no filler content, no AI sludge

#### sketch
Throwaway HTML mockups for comparing design directions (2-3 variants).
- **Output:** `sketches/NNN-stance-name/index.html` + `README.md`
- **Process:** Intake → Variants → Head-to-head → Pick winner
- **Variants:** Different design stances (density, emphasis, aesthetic, layout)

#### pretext
Creative browser demos with @chenglou/pretext (DOM-free text layout).
- **Output:** Single HTML file
- **Patterns:** Reflow around obstacle, text-as-geometry, kinetic type, shrink-wrap
- **Import:** `https://esm.sh/@chenglou/pretext@0.0.6`

### Writing & Music

#### humanizer
Remove AI writing patterns from text.
- **29 patterns** to detect and fix (emphasis inflation, promotional language, vague attributions, etc.)
- **Process:** Identify → Rewrite → Add soul → Final anti-AI pass
- **Key insight:** LLMs use statistical algorithms; output tends toward most likely completion

#### songwriting-and-ai-music
Songwriting craft and Suno AI music prompt engineering.
- **Structure:** ABABCB, AABA, ABAB, AAA
- **Suno prompts:** Genre + Mood + Era + Instruments + Vocal Style + Production + Dynamics
- **Metatags:** [Verse], [Chorus], [Bridge], [Whispered], [Belted], etc.

## Creative Standards (All Sub-Skills)

1. **First-render excellence** — output must be visually striking without revision rounds
2. **No filler content** — every element earns its place
3. **Cohesive aesthetic** — shared color palette, consistent typography, unified visual language
4. **Intentional variation** — never use default configs; vary per-section
5. **One invented element** — every project should include something the user didn't ask for

## References

Each sub-skill has its own `references/`, `templates/`, and `scripts/` directories. Load them with `skill_view(name="<skill>", file_path="references/...")`.
