#!/usr/bin/env python3
"""
Convert markdown reports to PDF using weasyprint
"""
import os
import sys
import markdown
from weasyprint import HTML, CSS

def md_to_pdf(md_path, pdf_path):
    # Read markdown
    with open(md_path, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    # Convert markdown to HTML with extensions
    html_content = markdown.markdown(
        md_content,
        extensions=[
            'tables',
            'fenced_code',
            'codehilite',
            'toc',
            'nl2br',
            'sane_lists'
        ],
        extension_configs={
            'codehilite': {
                'css_class': 'highlight',
                'use_pygments': True
            }
        }
    )
    
    # Add CSS styling
    styled_html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <style>
            @page {{
                size: A4;
                margin: 2cm 2.5cm;
                @bottom-center {{
                    content: counter(page) " / " counter(pages);
                    font-size: 9pt;
                    color: #666;
                }}
            }}
            body {{
                font-family: "DejaVu Sans", "Liberation Sans", Arial, sans-serif;
                font-size: 11pt;
                line-height: 1.6;
                color: #222;
                max-width: none;
            }}
            h1 {{
                color: #1a1a2e;
                border-bottom: 3px solid #6c5ce7;
                padding-bottom: 0.3em;
                margin-top: 1.5em;
                font-size: 22pt;
            }}
            h2 {{
                color: #2d3436;
                border-bottom: 1px solid #b2bec3;
                padding-bottom: 0.2em;
                margin-top: 1.3em;
                font-size: 17pt;
            }}
            h3 {{
                color: #34495e;
                margin-top: 1.2em;
                font-size: 14pt;
            }}
            h4 {{
                color: #4a4a4a;
                margin-top: 1em;
                font-size: 12pt;
            }}
            table {{
                border-collapse: collapse;
                width: 100%;
                margin: 1em 0;
                font-size: 9pt;
                page-break-inside: avoid;
            }}
            th, td {{
                border: 1px solid #dfe6e9;
                padding: 6px 10px;
                text-align: left;
            }}
            th {{
                background-color: #6c5ce7;
                color: white;
                font-weight: 600;
            }}
            tr:nth-child(even) td {{
                background-color: #f8f9fa;
            }}
            code {{
                font-family: "DejaVu Sans Mono", "Liberation Mono", Consolas, monospace;
                background-color: #f1f2f6;
                padding: 0.15em 0.4em;
                border-radius: 3px;
                font-size: 9pt;
            }}
            pre {{
                background-color: #2d3436;
                color: #dfe6e9;
                padding: 1em;
                border-radius: 5px;
                overflow-x: auto;
                page-break-inside: avoid;
                font-size: 8.5pt;
                line-height: 1.4;
            }}
            pre code {{
                background: none;
                padding: 0;
                color: inherit;
                font-size: inherit;
            }}
            .highlight {{
                background-color: #2d3436;
            }}
            blockquote {{
                border-left: 4px solid #6c5ce7;
                padding-left: 1em;
                margin: 1em 0;
                color: #636e72;
                font-style: italic;
            }}
            a {{
                color: #6c5ce7;
                text-decoration: none;
            }}
            ul, ol {{
                padding-left: 1.5em;
            }}
            li {{
                margin: 0.3em 0;
            }}
            hr {{
                border: none;
                border-top: 1px solid #b2bec3;
                margin: 1.5em 0;
            }}
            .badge {{
                display: inline-block;
                padding: 0.15em 0.5em;
                border-radius: 3px;
                font-size: 8pt;
                font-weight: bold;
                text-transform: uppercase;
            }}
            .badge-critical {{ background: #e74c3c; color: white; }}
            .badge-high {{ background: #e67e22; color: white; }}
            .badge-medium {{ background: #f39c12; color: white; }}
            .badge-low {{ background: #27ae60; color: white; }}
            .badge-info {{ background: #3498db; color: white; }}
            .badge-ok {{ background: #2ecc71; color: white; }}
            .badge-warn {{ background: #f39c12; color: white; }}
            .badge-pending {{ background: #95a5a6; color: white; }}
            header {{
                text-align: center;
                margin-bottom: 2em;
                padding-bottom: 1em;
                border-bottom: 2px solid #6c5ce7;
            }}
            header h1 {{ margin: 0; border: none; font-size: 26pt; }}
            header p {{ margin: 0.5em 0; color: #636e72; }}
            .meta-table {{
                width: 100%;
                margin-top: 1em;
            }}
            .meta-table td {{ border: none; padding: 4px 0; }}
            .meta-table td:first-child {{ font-weight: bold; width: 30%; }}
        </style>
    </head>
    <body>
        {html_content}
    </body>
    </html>
    """
    
    # Generate PDF
    HTML(string=styled_html).write_pdf(pdf_path)
    print(f"✅ PDF generado: {pdf_path}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python3 md_to_pdf.py <input.md> <output.pdf>")
        sys.exit(1)
    
    md_to_pdf(sys.argv[1], sys.argv[2])