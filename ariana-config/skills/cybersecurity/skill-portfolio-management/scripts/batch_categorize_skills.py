#!/usr/bin/env python3
"""
Batch Skill Categorization Script
Usage: python3 categorize_skills.py

Updates the 'category' field in SKILL.md frontmatter for multiple skills.
Run from /home/hermes or adjust skills_dir path.
"""

import os
import yaml
import glob

# ============================================================
# CONFIGURATION: Map skill directory names to categories
# ============================================================
SKILL_CATEGORIES = {
    # Cybersecurity - BRIDA core
    "brida-client-database": "cybersecurity",
    "brida-it-services": "cybersecurity",
    "compliance-governance-brida": "cybersecurity",
    "compliance-mapping": "cybersecurity",
    "crowdstrike-falcon": "cybersecurity",
    "edr-deployment": "cybersecurity",
    "email-security": "cybersecurity",
    "endpoint-security-brida": "cybersecurity",
    "fortinet-firewall": "cybersecurity",
    "fortinet-network-security": "cybersecurity",
    "fortinet-nfgw": "cybersecurity",
    "incident-response-brida": "cybersecurity",
    "mobile-security-brida": "cybersecurity",
    "network-architecture-assessment": "cybersecurity",
    "ot-ics-security-brida": "cybersecurity",
    "penetration-testing-brida": "cybersecurity",
    "phishing-defense-brida": "cybersecurity",
    "ransomware-defense-brida": "cybersecurity",
    "security-awareness-training": "cybersecurity",
    "security-operations-brida": "cybersecurity",
    "vulnerability-management-brida": "cybersecurity",
    "web-application-security-brida": "cybersecurity",
    "aws-cloud-security": "cybersecurity",
    
    # BRIDA consulting/red teaming
    "brida-cybersecurity-consulting": "cybersecurity",
    "brida-web-application-security": "cybersecurity",
    "brida-zero-trust-architecture": "cybersecurity",
    "brida-red-teaming": "offensive-security",
    
    # Communication/Social
    "yuanbao": "social-media",
    "xurl": "social-media",
    "user-interaction-style": "configuration",
    
    # Ecommerce
    "ecommerce-dropshipping": "ecommerce",
    
    # Creative/Audio
    "audiocraft-audio-generation": "creative",
    "heartmula": "creative",
    
    # Automation
    "chatbot-appointment-automation": "automation",
    "hermes-daily-check": "automation",
    "terminal-shell-operations": "automation",
    
    # Agent skills
    "claude-code": "autonomous-ai-agents",
    "codex": "autonomous-ai-agents",
    "computer-use": "autonomous-ai-agents",
    "hermes-agent": "autonomous-ai-agents",
    "opencode": "autonomous-ai-agents",
    "macos-computer-use": "autonomous-ai-agents",
    
    # Creative (already categorized but verifying)
    "architecture-diagram": "creative",
    "ascii-art": "creative",
    "ascii-video": "creative",
    "baoyu-infographic": "creative",
    "claude-design": "creative",
    "comfyui": "creative",
    "creative-design": "creative",
    "design-md": "creative",
    "excalidraw": "creative",
    "humanizer": "creative",
    "manim-video": "creative",
    "p5js": "creative",
    "popular-web-designs": "creative",
    "pretext": "creative",
    "sketch": "creative",
    "songwriting-and-ai-music": "creative",
    "touchdesigner-mcp": "creative",
    "hermes-themes": "creative",
    
    # Cybersecurity umbrella skills
    "cybersecurity-brida": "cybersecurity",
    "cybersecurity-consulting-methodology": "cybersecurity",
    "fortinet-network-security-brida": "cybersecurity",
    "pentesting-brida": "cybersecurity",
    "pentesting-tool-verification": "cybersecurity",
    "skill-portfolio-management": "cybersecurity",
    
    # Data science
    "jupyter-live-kernel": "data-science",
    
    # Email
    "himalaya": "email",
    
    # GitHub
    "codebase-inspection": "github",
    "github-auth": "github",
    "github-code-review": "github",
    "github-issues": "github",
    "github-pr-workflow": "github",
    "github-repo-management": "github",
    
    # Media
    "gif-search": "media",
    "media": "media",
    "songsee": "media",
    "youtube-content": "media",
    
    # MLOps
    "evaluating-llms-harness": "mlops",
    "huggingface-hub": "mlops",
    "llama-cpp": "mlops",
    "mlops": "mlops",
    "segment-anything-model": "mlops",
    "serving-llms-vllm": "mlops",
    "weights-and-biases": "mlops",
    
    # Note-taking
    "obsidian": "note-taking",
    
    # Productivity
    "airtable": "productivity",
    "docx": "productivity",
    "google-workspace": "productivity",
    "google-workspace-gmail-api": "productivity",
    "maps": "productivity",
    "nano-pdf": "productivity",
    "notion": "productivity",
    "pdf": "productivity",
    "petdex": "productivity",
    "powerpoint": "productivity",
    "productivity": "productivity",
    "teams-meeting-pipeline": "productivity",
    "tui-widgets": "productivity",
    "xlsx": "productivity",
    "ocr-and-documents": "productivity",
    "hermes-backup": "productivity",
    "hermes-desktop-plugins": "software-development",
    
    # Research
    "arxiv": "research",
    "blogwatcher": "research",
    "llm-wiki": "research",
    "polymarket": "research",
    "research": "research",
    "research-paper-writing": "research",
    
    # Smart home
    "openhue": "smart-home",
    
    # Software development
    "dogfood": "software-development",
    "hermes-agent-skill-authoring": "software-development",
    "inspecting-hermes-desktop-dom": "software-development",
    "node-inspect-debugger": "software-development",
    "plan": "software-development",
    "python-debugpy": "software-development",
    "requesting-code-review": "software-development",
    "simplify-code": "software-development",
    "software-development": "software-development",
    "spike": "software-development",
    "systematic-debugging": "software-development",
    "test-driven-development": "software-development",
    
    # Kanban
    "kanban-orchestrator": "automation",
    "kanban-worker": "automation",
}

# ============================================================
# EXECUTION
# ============================================================
def categorize_skills(skills_dir="/home/hermes/.hermes/skills"):
    updated = []
    errors = []
    
    for skill_name, category in SKILL_CATEGORIES.items():
        paths = glob.glob(os.path.join(skills_dir, "**", skill_name), recursive=True)
        paths = [p for p in paths if os.path.isdir(p) and os.path.basename(p) == skill_name]
        
        if not paths:
            errors.append(f"{skill_name}: directory not found")
            continue
            
        skill_file = os.path.join(paths[0], "SKILL.md")
        if not os.path.exists(skill_file):
            errors.append(f"{skill_name}: SKILL.md not found")
            continue
            
        with open(skill_file, 'r') as f:
            content = f.read()
            
        if not content.startswith('---'):
            errors.append(f"{skill_name}: no YAML frontmatter")
            continue
            
        parts = content.split('---', 2)
        if len(parts) < 3:
            errors.append(f"{skill_name}: invalid frontmatter format")
            continue
            
        fm = yaml.safe_load(parts[1])
        fm['category'] = category
        new_fm = yaml.dump(fm, sort_keys=False, allow_unicode=True)
        new_content = f'---\n{new_fm}---{parts[2]}'
        
        with open(skill_file, 'w') as f:
            f.write(new_content)
            
        updated.append(f"{skill_name} → {category}")
    
    print(f"✅ Updated: {len(updated)}")
    for u in updated:
        print(f"  {u}")
        
    if errors:
        print(f"\n❌ Errors: {len(errors)}")
        for e in errors:
            print(f"  {e}")
    
    return updated, errors


def verify_categories(skills_dir="/home/hermes/.hermes/skills"):
    """Verify all skills have categories assigned."""
    missing = []
    for skill_file in glob.glob(os.path.join(skills_dir, "**", "SKILL.md"), recursive=True):
        with open(skill_file) as f:
            content = f.read()
        if not content.startswith('---'):
            missing.append(skill_file)
            continue
        parts = content.split('---', 2)
        if len(parts) >= 3:
            fm = yaml.safe_load(parts[1])
            if not fm.get('category'):
                missing.append(skill_file)
    
    if missing:
        print(f"Skills missing category: {len(missing)}")
        for m in missing:
            print(f"  {m}")
    else:
        print("✅ All skills have categories assigned")
    
    return missing


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "verify":
        verify_categories()
    else:
        categorize_skills()