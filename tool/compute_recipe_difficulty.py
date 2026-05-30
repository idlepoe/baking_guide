# -*- coding: utf-8 -*-
"""Compute objective difficulty (1-5) from step count and ingredient count."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIST_PATH = ROOT / "assets" / "json" / "recipe_list.json"
RECIPES_DIR = ROOT / "assets" / "json" / "recipes"

# 공정·재료 가중치 (재료는 종류 수가 많을수록 계량·준비 부담 증가)
STEP_WEIGHT = 0.55
INGREDIENT_WEIGHT = 0.45


def score_to_difficulty(score: float, boundaries: list[float]) -> int:
    for i, bound in enumerate(boundaries, start=1):
        if score <= bound:
            return i
    return 5


def compute_boundaries(scores: list[float]) -> list[float]:
    """Quintile boundaries — score 구간을 1~5로 균등 분할."""
    sorted_scores = sorted(scores)
    n = len(sorted_scores)
    boundaries: list[float] = []
    for level in range(1, 5):
        idx = min(n - 1, max(0, round(n * level / 5) - 1))
        boundaries.append(sorted_scores[idx])
    # 단조 증가 보장
    for i in range(1, len(boundaries)):
        if boundaries[i] < boundaries[i - 1]:
            boundaries[i] = boundaries[i - 1]
    return boundaries


def main() -> None:
    items = json.loads(LIST_PATH.read_text(encoding="utf-8"))
    metrics: list[tuple[dict, int, int, float]] = []

    for item in items:
        detail_path = RECIPES_DIR / f"{item['id']}.json"
        detail = json.loads(detail_path.read_text(encoding="utf-8"))
        step_count = len(detail.get("steps", []))
        ingredient_count = len(detail.get("ingredients", []))
        score = step_count * STEP_WEIGHT + ingredient_count * INGREDIENT_WEIGHT
        metrics.append((item, step_count, ingredient_count, score))

    scores = [m[3] for m in metrics]
    boundaries = compute_boundaries(scores)

    print(f"Score boundaries for difficulty 1-4 max: {[round(b, 2) for b in boundaries]}")
    print(f"Score range: {min(scores):.2f} ~ {max(scores):.2f}")
    print()

    difficulty_counts = {i: 0 for i in range(1, 6)}
    for item, steps, ings, score in metrics:
        diff = score_to_difficulty(score, boundaries)
        item["difficulty"] = diff
        difficulty_counts[diff] += 1
        print(
            f"diff={diff}  score={score:5.2f}  "
            f"steps={steps:2d} ings={ings:2d}  {item['id']}"
        )

    LIST_PATH.write_text(
        json.dumps(items, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print()
    print("Distribution:", difficulty_counts)
    print(f"Updated {LIST_PATH}")


if __name__ == "__main__":
    main()
