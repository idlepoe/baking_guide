# -*- coding: utf-8 -*-
"""Build RecipeDetail JSON files from compact specs."""
from __future__ import annotations

import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "assets" / "json" / "recipes"


def _kp(title: str, items: list[str], image: str = "assets/images/keypoints/exam.png") -> dict:
    m = {
        "시험 정보": "exam.png",
        "반죽": "mixer.png",
        "발효": "fermentation.png",
        "성형": "shaping.png",
        "굽기": "oven.png",
        "토핑": "shaping.png",
        "주요 감점 포인트": "warning.png",
        "칼집·성형": "shaping.png",
        "비스킷 토핑": "mixer.png",
    }
    img = f"assets/images/keypoints/{m.get(title, 'exam.png')}"
    return {"title": title, "imageUrl": img, "items": items}


def _step(
    step_no: int,
    title: str,
    recipe_id: str,
    description: list[str],
    *,
    tips: list[str] | None = None,
    checklist: list[tuple[str, str]] | None = None,
    deductions: list[tuple[str, str]] | None = None,
    timers: list[dict] | None = None,
    calculators: list[dict] | None = None,
    estimated: int = 300,
    image_suffix: str | None = None,
) -> dict:
    if image_suffix is None:
        if step_no <= 8:
            image_suffix = "step3.jpg" if (OUT / recipe_id / "step3.jpg").exists() else "step1.jpg"
        elif step_no <= 14:
            image_suffix = "step4.jpg" if (OUT / recipe_id / "step4.jpg").exists() else "step2.jpg"
        else:
            image_suffix = "evaluation.jpg" if (OUT / recipe_id / "evaluation.jpg").exists() else "step2.jpg"
    return {
        "stepNo": step_no,
        "title": title,
        "estimatedTimeSec": estimated,
        "imageUrl": f"assets/images/recipes/{recipe_id}/{image_suffix}",
        "description": description,
        "tips": tips or [],
        "checklist": [{"id": i, "text": t} for i, t in (checklist or [])],
        "deductionPoints": [
            {"severity": s, "text": t} for s, t in (deductions or [])
        ],
        "timers": timers or [],
        "calculators": calculators or [],
        "images": [],
    }


def _ing(name: str, amount: float, cat: str, unit: str = "g") -> dict:
    return {"name": name, "amount": amount, "unit": unit, "category": cat}


def build_detail(
    recipe_id: str,
    name: str,
    category: str,
    exam_time_sec: int,
    mixing_method: str,
    oven: dict,
    fermentation: dict,
    key_points: list[dict],
    ingredients: list[dict],
    steps: list[dict],
    result_evaluation: list[tuple[str, str]],
) -> dict:
    return {
        "id": recipe_id,
        "name": name,
        "category": category,
        "thumbnailUrl": f"assets/images/recipes/{recipe_id}/main.jpg",
        "summary": {
            "examTimeSec": exam_time_sec,
            "mixingMethod": mixing_method,
            "oven": oven,
            "fermentation": fermentation,
            "keyPoints": key_points,
        },
        "ingredients": ingredients,
        "steps": steps,
        "resultEvaluation": [{"id": i, "text": t} for i, t in result_evaluation],
    }


def write_recipe(data: dict) -> None:
    path = OUT / f"{data['id']}.json"
    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"wrote {path.name}")


def update_pullman_paths() -> None:
    path = OUT / "pullman_bread.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    data["thumbnailUrl"] = "assets/images/recipes/pullman_bread/main.jpg"
    for step in data["steps"]:
        n = step["stepNo"]
        if n <= 4:
            suf = "step1.jpg"
        elif n <= 8:
            suf = "step2.jpg"
        elif n <= 13:
            suf = "step3.jpg"
        else:
            suf = "evaluation.jpg"
        step["imageUrl"] = f"assets/images/recipes/pullman_bread/{suf}"
    write_recipe(data)
