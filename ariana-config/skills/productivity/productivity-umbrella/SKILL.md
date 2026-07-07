---
name: productivity
description: "Productivity tools — documents, spreadsheets, notes, PDFs, maps, and workspace automation. Use when creating documents, managing notes, working with spreadsheets, or automating productivity workflows."
version: 1.1.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [productivity, documents, notes, spreadsheets, pdf, maps, workspace, automation]
    related_skills: [airtable, google-workspace, maps, nano-pdf, notion, obsidian, ocr-and-documents, powerpoint, teams-meeting-pipeline, word]
---

# Productivity — Umbrella Skill

Covers document creation, note-taking, spreadsheets, PDF editing, maps, and workspace automation.

## Decision Tree

| Task | Sub-Skill | Trigger Keywords |
|---|---|---|
| Airtable CRUD | `airtable` | airtable, records, bases, upserts |
| Google Workspace (Gmail, Calendar, Drive) | `google-workspace` | gmail, google calendar, google drive, gws |
| Maps, geocoding, routes | `maps` | geocode, POI, route, timezone, maps |
| Edit PDF text | `nano-pdf` | edit PDF, PDF text, nano-pdf |
| Notion pages/databases | `notion` | notion, ntn, notion API |
| Obsidian vault | `obsidian` | obsidian, vault, markdown notes |
| OCR and document extraction | `ocr-and-documents` | OCR, extract text, PDF to text, scan |
| PowerPoint presentations | `powerpoint` | powerpoint, pptx, slides, presentation |
| Word documents | `word` | word, docx, microsoft word, doc |
| Teams meeting pipeline | `teams-meeting-pipeline` | teams meeting, meeting summary, teams |

## Documents & Notes

### nano-pdf
Edit PDF text/typos/titles via nano-pdf CLI.
```bash
nano-pdf edit document.pdf
```

### ocr-and-documents
Extract text from PDFs and scans.
```bash
# pymupdf for text extraction
python -c "import fitz; doc = fitz.open('file.pdf'); print(doc[0].get_text())"
```

### Microsoft Word documents
Create, read, edit `.docx` files via python-docx (installed in ~/venvs/venv2).
```bash
# Using the virtual environment at ~/venvs/venv2
~/venvs/venv2/bin/python -c "
import docx
doc = docx.Document()
doc.add_heading('Document Title', 0)
doc.add_paragraph('Add a paragraph.')
doc.save('output.docx')
"
```

### PowerPoint presentations
Create, read, edit `.pptx` files via python-pptx (installed in ~/venvs/venv2).
```bash
# Using the virtual environment at ~/venvs/venv2
~/venvs/venv2/bin/python -c "
from pptx import Presentation
prs = Presentation()
title_slide_layout = prs.slide_layouts[0]
slide = prs.slides.add_slide(title_slide_layout)
title = slide.shapes.title
subtitle = slide.placeholders[1]
title.text = 'Hello, World!'
subtitle.text = 'This is a subtitle.'
prs.save('test.pptx')
"
```

### notion
Notion API + ntn CLI for pages and databases.
```bash
ntn pages create --database <id> --title "New Page"
```

### obsidian
Read, search, create, and edit notes in the Obsidian vault.
```bash
# Vault location from OBSIDIAN_VAULT_PATH env var
```

## Spreadsheets & Data

### airtable
Airtable REST API via curl.
```bash
curl -s "https://api.airtable.com/v0/{baseId}/{tableName}" \
  -H "Authorization: Bearer ***"
```

### google-workspace
Gmail, Calendar, Drive, Docs, Sheets via gws CLI or Python.
```bash
gws gmail list
gws calendar list
```

## Maps & Location

### maps
Geocode, POIs, routes, timezones via OpenStreetMap/OSRM.
```bash
curl -s "https://nominatim.openstreetmap.org/search?q=London&format=json"
```

## Meetings

### teams-meeting-pipeline
Operate the Teams meeting summary pipeline via Hermes CLI.