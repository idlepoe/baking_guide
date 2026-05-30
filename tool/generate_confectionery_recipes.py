# -*- coding: utf-8 -*-
"""Generate confectionery RecipeDetail JSON from scripts/confectionery_specs.py."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from confectionery_specs import CONFECTIONERY_SPECS  # noqa: E402

OUT = ROOT / "assets" / "json" / "recipes"

KP_ICONS = {
    "시험 정보": "exam.png",
    "반죽": "mixer.png",
    "발효": "fermentation.png",
    "성형": "shaping.png",
    "굽기": "oven.png",
    "토핑": "shaping.png",
    "주요 감점 포인트": "warning.png",
}

MIXING_METHOD_MAP = {
    "choux_paste": "choux",
}

DISPLAY_NAME_OVERRIDES = {
    "madera_cake": "마데라케이크",
}


def kp(title: str, items: list[str]) -> dict:
    img = KP_ICONS.get(title, "exam.png")
    return {
        "title": title,
        "imageUrl": f"assets/images/keypoints/{img}",
        "items": items,
    }


def step_image(rid: str, step_no: int, total: int) -> str:
    folder = ROOT / "assets" / "images" / "recipes" / rid
    if step_no == total and (folder / "evaluation.jpg").exists():
        return "evaluation.jpg"
    if step_no <= max(1, total // 2) and (folder / "step1.jpg").exists():
        return "step1.jpg"
    if (folder / "step2.jpg").exists():
        return "step2.jpg"
    if (folder / "step1.jpg").exists():
        return "step1.jpg"
    return "main.jpg"


def build_step(rid: str, step_no: int, total: int, raw: dict) -> dict:
    title = raw["title"]
    if not title.startswith(f"{step_no:02d}."):
        title = f"{step_no:02d}. {title.split('. ', 1)[-1] if '. ' in title else title}"

    return {
        "stepNo": step_no,
        "title": title,
        "estimatedTimeSec": raw.get("estimatedTimeSec", 300),
        "imageUrl": f"assets/images/recipes/{rid}/{step_image(rid, step_no, total)}",
        "description": raw["description"],
        "tips": raw.get("tips", []),
        "checklist": raw.get("checklist", []),
        "deductionPoints": raw.get("deductionPoints", []),
        "timers": raw.get("timers", []),
        "calculators": raw.get("calculators", []),
        "images": [],
    }


def normalize_oven(oven: dict) -> dict:
    return {
        "top": oven["top"],
        "bottom": oven["bottom"],
        "unit": oven.get("unit", "celsius"),
        "timeSec": oven.get("timeSec", 600),
    }


def build_recipe(spec: dict) -> dict:
    rid = spec["id"]
    name = DISPLAY_NAME_OVERRIDES.get(rid, spec["name"])
    mixing = MIXING_METHOD_MAP.get(spec["mixingMethod"], spec["mixingMethod"])

    raw_steps = spec["steps"]
    total = len(raw_steps)
    steps = [
        build_step(rid, i + 1, total, raw)
        for i, raw in enumerate(raw_steps)
    ]

    key_points = [kp(kp_item["title"], kp_item["items"]) for kp_item in spec["keyPoints"]]

    ingredients = []
    for ing in spec["ingredients"]:
        item = {
            "name": ing["name"],
            "amount": ing["amount"],
            "unit": ing.get("unit", "g"),
            "category": ing["category"],
        }
        if "weighGroupId" in ing:
            item["weighGroupId"] = ing["weighGroupId"]
        ingredients.append(item)

    data = {
        "id": rid,
        "name": name,
        "category": spec["category"],
        "thumbnailUrl": f"assets/images/recipes/{rid}/main.jpg",
        "summary": {
            "examTimeSec": spec["examTimeSec"],
            "mixingMethod": mixing,
            "oven": normalize_oven(spec["oven"]),
            "fermentation": spec.get("fermentation", {}),
            "keyPoints": key_points,
        },
        "ingredients": ingredients,
        "steps": steps,
        "resultEvaluation": spec["resultEvaluation"],
    }

    if spec.get("weighGroups"):
        data["weighGroups"] = spec["weighGroups"]

    return data


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    for spec in CONFECTIONERY_SPECS:
        rid = spec["id"]
        if rid == "butter_cookie":
            print("skip butter_cookie.json (kept existing)")
            continue
        data = build_recipe(spec)
        path = OUT / f"{rid}.json"
        path.write_text(
            json.dumps(data, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        print(f"wrote {path.name} ({len(data['steps'])} steps)")


if __name__ == "__main__":
    main()
