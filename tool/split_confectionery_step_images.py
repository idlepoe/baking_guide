# -*- coding: utf-8 -*-
"""Split confectionery textbook composite pages into stepN.jpg files."""
from __future__ import annotations

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "assets" / "raw_images"
DEST_ROOT = ROOT / "assets" / "images" / "recipes"

KR_TO_ID = {
    "과일케이크": "fruit_cake",
    "다쿠와즈": "dacquoise",
    "마데라케이크": "madera_cake",
    "마드레느": "madeleine",
    "버터스펀지케이크(공립법)": "butter_sponge_cake_gongrip",
    "버터스펀지케이크(별립법)": "butter_sponge_cake_separated",
    "브라우니": "brownie",
    "소프트롤케이크": "soft_roll_cake",
    "쇼트브레드 쿠키": "shortbread_cookie",
    "슈": "choux",
    "시퐁케이크": "chiffon_cake",
    "젤리롤케이크": "jelly_roll_cake",
    "초코롤케이크": "choco_roll_cake",
    "초코머핀": "choco_muffin",
    "치즈케이크": "cheesecake",
    "타르트": "tart",
    "파운드 케이크": "pound_cake",
    "호두파이": "walnut_pie",
    "흑미롤케이크": "black_rice_roll_cake",
}

# 교재 합성 페이지 기준 단계 수 (표지·배합표 제외 이미지에서 확인)
STEP_COUNTS: dict[str, int] = {
    "fruit_cake": 15,
    "dacquoise": 13,
    "madera_cake": 15,
    "madeleine": 14,
    "butter_sponge_cake_gongrip": 11,
    "butter_sponge_cake_separated": 12,
    "brownie": 10,
    "soft_roll_cake": 15,
    "shortbread_cookie": 14,
    "choux": 14,
    "chiffon_cake": 13,
    "jelly_roll_cake": 14,
    "choco_roll_cake": 13,
    "choco_muffin": 11,
    "cheesecake": 14,
    "tart": 15,
    "pound_cake": 11,
    "walnut_pie": 15,
    "black_rice_roll_cake": 14,
}


def _save_jpg(image: Image.Image, path: Path) -> None:
    rgb = image.convert("RGB")
    rgb.save(path, "JPEG", quality=92)


def _grid_4x2(w: int, h: int) -> list[tuple[int, int, int, int]]:
    cw, ch = w // 4, h // 2
    boxes: list[tuple[int, int, int, int]] = []
    for row in range(2):
        for col in range(4):
            boxes.append((col * cw, row * ch, (col + 1) * cw, (row + 1) * ch))
    return boxes


def _page2_boxes(w: int, h: int, count: int) -> list[tuple[int, int, int, int]]:
    """Second composite page: `count` steps (total - 8)."""
    if count <= 4:
        cw = w // count
        return [(i * cw, 0, (i + 1) * cw, h) for i in range(count)]

    cw4 = w // 4
    half = h // 2
    boxes = [(i * cw4, 0, (i + 1) * cw4, half) for i in range(4)]
    bottom = count - 4
    cb = w // bottom
    boxes.extend((i * cb, half, (i + 1) * cb, h) for i in range(bottom))
    return boxes


def _split_composite(src: Path, dest: Path, *, start: int, boxes: list[tuple[int, int, int, int]]) -> int:
    with Image.open(src) as im:
        step = start
        for box in boxes:
            _save_jpg(im.crop(box), dest / f"step{step}.jpg")
            step += 1
    return step - start


def split_recipe(kr_name: str, recipe_id: str, total_steps: int) -> None:
    src_dir = RAW / kr_name
    jpgs = sorted(src_dir.glob("*.jpg"), key=lambda p: p.name)
    if len(jpgs) < 4:
        raise FileNotFoundError(f"{kr_name}: need 4+ jpgs, got {len(jpgs)}")

    dest = DEST_ROOT / recipe_id
    dest.mkdir(parents=True, exist_ok=True)

    # 표지·배합표 유지, step*.jpg만 교체
    for old in dest.glob("step*.jpg"):
        old.unlink()

    _save_jpg(Image.open(jpgs[0]), dest / "main.jpg")
    _save_jpg(Image.open(jpgs[1]), dest / "cover.jpg")

    page1 = jpgs[2]
    page2 = jpgs[3]

    with Image.open(page1) as im:
        w, h = im.size
        boxes1 = _grid_4x2(w, h)

    page2_count = total_steps - 8
    with Image.open(page2) as im:
        w2, h2 = im.size
        boxes2 = _page2_boxes(w2, h2, page2_count)

    n1 = _split_composite(page1, dest, start=1, boxes=boxes1)
    n2 = _split_composite(page2, dest, start=9, boxes=boxes2)
    print(f"{recipe_id}: main, cover + {n1 + n2} steps (page2={page2_count})")


def main() -> None:
    for kr, rid in KR_TO_ID.items():
        total = STEP_COUNTS[rid]
        split_recipe(kr, rid, total)


if __name__ == "__main__":
    main()
