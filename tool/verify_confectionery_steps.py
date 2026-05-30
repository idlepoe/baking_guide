# -*- coding: utf-8 -*-
"""Verify confectionery recipe steps and step images."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
recipes = json.loads((ROOT / "assets/json/recipe_list.json").read_text(encoding="utf-8"))
conf = [r for r in recipes if r.get("examType") == "confectionery"]
errors: list[str] = []

for r in conf:
    rid = r["id"]
    data = json.loads((ROOT / f"assets/json/recipes/{rid}.json").read_text(encoding="utf-8"))
    n = len(data["steps"])
    img_dir = ROOT / f"assets/images/recipes/{rid}"
    if rid == "butter_cookie":
        print(f"{rid}: {n} steps (legacy images, skip per-step check)")
        continue
    missing = [
        s["stepNo"]
        for s in data["steps"]
        if not (img_dir / f"step{s['stepNo']}.jpg").exists()
    ]
    if missing:
        errors.append(f"{rid}: missing images for steps {missing}")
    print(f"{rid}: {n} steps" + (" (missing imgs)" if missing else ""))

if errors:
    print("\nERRORS:")
    for e in errors:
        print(" ", e)
    raise SystemExit(1)
print("\nALL OK")
