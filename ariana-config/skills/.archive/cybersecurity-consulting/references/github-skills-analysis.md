# Referencia: Análisis de Repositorios GitHub para Skills

## Flujo de análisis

1. `curl -s https://api.github.com/repos/USER/REPO` — metadatos
2. `curl -s https://api.github.com/repos/USER/REPO/contents/` — estructura
3. `curl -s https://raw.githubusercontent.com/USER/REPO/main/README.md` — documentación

## Repositorios analizados (Jun 2026)

### n8n-io/skills
- 13 skills oficiales de n8n + 1 meta-skill
- Para automatizar flujos de trabajo en n8n
- Ideal para chatbots de citas médicas

### Shopify/Shopify-AI-Toolkit
- 20+ skills de Shopify (admin, customers, dev, payments, etc.)
- Plugins para Claude Code, Codex, Cursor, Hermes, Gemini CLI
- Ideal para tienda de e-commerce con dropshipping

### Shopify AI Toolkit (Documentación)
- https://shopify.dev/docs/apps/build/ai-toolkit
- Documentación oficial, complementar con el repo de GitHub
