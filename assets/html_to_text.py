#!/usr/bin/env python3
"""
html_to_txt.py

Usage:
    python html_to_txt.py            # processes *.html in current directory
    python html_to_txt.py -r        # processes recursively (all .html under cwd)

Requires:
    pip install beautifulsoup4 lxml
"""

import argparse
import glob
import os
from bs4 import BeautifulSoup

def process_file(path, output_dir=None):
    with open(path, "r", encoding="utf-8") as f:
        html = f.read()

    # Use lxml if installed (faster / more robust), fall back to html.parser
    soup = BeautifulSoup(html, "lxml")

    p = soup.find("p")
    if p is None:
        print(f"[WARN] no <p> found in: {path}")
        return False

    # get_text with separator ensures tags are separated by spaces
    text = p.get_text(separator=" ")

    # replace any CR / LF with a single space
    text = text.replace("\r", " ").replace("\n", " ")

    # normalize repeated whitespace (tabs, multiple spaces, NBSP) to single regular space
    text = " ".join(text.split())

    # Optional: strip leading/trailing spaces
    text = text.strip()

    base = os.path.splitext(os.path.basename(path))[0]
    out_name = base + ".txt"
    if output_dir:
        os.makedirs(output_dir, exist_ok=True)
        out_path = os.path.join(output_dir, out_name)
    else:
        out_path = os.path.join(os.path.dirname(path), out_name)

    with open(out_path, "w", encoding="utf-8") as out:
        out.write(text)

    print(f"[OK] {path} -> {out_path}")
    return True

def main():
    parser = argparse.ArgumentParser(description="Extract first <p> text from HTML files and save as .txt")
    parser.add_argument("-r", "--recursive", action="store_true", help="process files recursively")
    parser.add_argument("-o", "--outdir", default=None, help="optional output directory for .txt files")
    args = parser.parse_args()

    if args.recursive:
        files = glob.glob("**/*.html", recursive=True) + glob.glob("**/*.htm", recursive=True)
    else:
        files = glob.glob("*.html") + glob.glob("*.htm")

    if not files:
        print("No .html/.htm files found.")
        return

    for p in files:
        process_file(p, output_dir=args.outdir)

if __name__ == "__main__":
    main()

