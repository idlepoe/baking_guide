# -*- coding: utf-8 -*-
"""Add weighGroups / weighGroupId to all recipe JSON files."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RECIPES = ROOT / "assets" / "json" / "recipes"

DRY_GROUP_ID = "dry_powder"
DRY_GROUP_LABEL = "가루류·합침 가능"
DRY_CATEGORIES = frozenset({"flour", "sweetener", "salt", "improver", "powder"})

# 재료명 키워드 → 단독 계량 (충전·토핑·바르기용 등)
ALONE_NAME_KEYWORDS = (
    "충전",
    "토핑",
    "바르기용",
    "비스킷",
    "커스터드",
    "소보로",
    "단팥",
    "계피",
    "오트밀",
    "건포도",
    "통조림",
    "아몬드",
)


def should_be_alone(name: str, category: str, recipe_id: str) -> bool:
    if category in ("liquid", "egg", "yeast", "fat", "filling"):
        return True
    for kw in ALONE_NAME_KEYWORDS:
        if kw in name:
            return True
    if recipe_id == "butter_cookie" and category in ("sweetener", "salt"):
        return True
    if recipe_id == "mocha_bread" and name in ("베이킹파우더", "인스턴트커피"):
        return True
    return False


def assign_weigh_group_id(name: str, category: str, recipe_id: str) -> str | None:
    if should_be_alone(name, category, recipe_id):
        return None
    if category in DRY_CATEGORIES:
        return DRY_GROUP_ID
    if category == "spice":
        return DRY_GROUP_ID
    return None


def apply_to_recipe(data: dict) -> bool:
    ingredients = data.get("ingredients")
    if not ingredients:
        return False

    recipe_id = data.get("id", "")
    changed = False
    dry_count = 0
    for ing in ingredients:
        gid = assign_weigh_group_id(ing["name"], ing["category"], recipe_id)
        if gid:
            dry_count += 1
        if ing.get("weighGroupId") != gid:
            changed = True
        if gid:
            ing["weighGroupId"] = gid
        elif "weighGroupId" in ing:
            del ing["weighGroupId"]
            changed = True

    if dry_count >= 2:
        new_groups = [{"id": DRY_GROUP_ID, "label": DRY_GROUP_LABEL}]
        if data.get("weighGroups") != new_groups:
            data["weighGroups"] = new_groups
            changed = True
    else:
        if data.get("weighGroups"):
            data["weighGroups"] = []
            changed = True

    return changed


def ordered_recipe_dict(data: dict) -> dict:
    preferred = (
        "id",
        "name",
        "category",
        "thumbnailUrl",
        "summary",
        "weighGroups",
        "ingredients",
        "steps",
        "resultEvaluation",
    )
    ordered: dict = {}
    for key in preferred:
        if key in data:
            ordered[key] = data[key]
    for key, value in data.items():
        if key not in ordered:
            ordered[key] = value
    return ordered


def main() -> None:
    for path in sorted(RECIPES.glob("*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        apply_to_recipe(data)
        text = json.dumps(ordered_recipe_dict(data), ensure_ascii=False, indent=2) + "\n"
        path.write_text(text, encoding="utf-8")
        dry = sum(1 for i in data["ingredients"] if i.get("weighGroupId") == DRY_GROUP_ID)
        groups = len(data.get("weighGroups") or [])
        print(f"{path.name}: dry_powder={dry}, weighGroups={groups}")


if __name__ == "__main__":
    main()
