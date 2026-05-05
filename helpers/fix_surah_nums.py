#!/usr/bin/env python3
"""
fix_surah_nums.py

Usage:
    python fix_surah_nums.py input.json output.json
    python fix_surah_nums.py input.json --inplace
"""

import json
import argparse
import shutil
from pathlib import Path

def fix_surah_numbers(data):
    """
    Walks data['quran_pages_info'] (expected to be a list of dicts).
    Each time an entry has verseNum == 0 (after int conversion), increment surah counter
    and set entry['surahNum'] to that counter. For other entries set current surahNum.
    """
    if not isinstance(data, dict):
        raise ValueError("Expected top-level JSON object (dict).")
    key = "quran_pages_info"
    if key not in data:
        raise KeyError(f"Top-level key '{key}' not found in JSON.")

    arr = data[key]
    if not isinstance(arr, list):
        raise ValueError(f"Expected '{key}' to be a list.")

    surah = 0
    for i, entry in enumerate(arr):
        # Ensure entry is a dict
        if not isinstance(entry, dict):
            # leave it unchanged but continue
            continue

        verse_val = entry.get("verseNum", None)
        # try to interpret verseVal as an int (safe fallback)
        try:
            verse_int = int(verse_val) if verse_val is not None else None
        except Exception:
            verse_int = None

        if verse_int == 0:
            surah += 1
            entry["surahNum"] = surah
        else:
            # If we haven't seen any verseNum==0 yet, surah remains 0.
            # Assign current surah value (0 if none encountered yet).
            entry["surahNum"] = surah

    return data

def main():
    p = argparse.ArgumentParser(description="Fix surahNum values in quran_pages_info.")
    p.add_argument("input", help="Input JSON file")
    p.add_argument("output", nargs="?", help="Output JSON file (omit to use --inplace)")
    p.add_argument("--inplace", action="store_true", help="Modify input file in-place (creates backup)")
    p.add_argument("--backup-ext", default=".bak", help="Backup extension when using --inplace (default: .bak)")
    args = p.parse_args()

    input_path = Path(args.input)
    if not input_path.exists():
        raise SystemExit(f"Input file not found: {input_path}")

    # Load JSON
    with input_path.open("r", encoding="utf-8") as f:
        data = json.load(f)

    # Process
    fixed = fix_surah_numbers(data)

    # Prepare output
    if args.inplace:
        backup_path = input_path.with_suffix(input_path.suffix + args.backup_ext)
        shutil.copyfile(input_path, backup_path)
        out_path = input_path
    else:
        if args.output:
            out_path = Path(args.output)
        else:
            raise SystemExit("Either provide an output file or use --inplace.")

    # Write JSON preserving unicode (so Arabic stays readable)
    with out_path.open("w", encoding="utf-8") as f:
        json.dump(fixed, f, ensure_ascii=False, indent=2)

    print(f"Wrote fixed file to: {out_path}")
    if args.inplace:
        print(f"Backup of original saved as: {backup_path}")

if __name__ == "__main__":
    main()

