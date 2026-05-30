# -*- coding: utf-8 -*-
"""Prepare images for recipes that need composite splitting or curated PNG sources."""
from __future__ import annotations

import shutil
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "assets" / "raw_images"
DEST = ROOT / "assets" / "images" / "recipes"

PULLMAN_RAW = RAW / "풀만"
EMERGENCY_RAW = RAW / "비상식빵"


def _clear_dest(recipe_id: str) -> Path:
    dest = DEST / recipe_id
    dest.mkdir(parents=True, exist_ok=True)
    for old in dest.iterdir():
        if old.is_file():
            old.unlink()
    return dest


def _save_jpg(image: Image.Image, path: Path) -> None:
    rgb = image.convert("RGB")
    rgb.save(path, "JPEG", quality=92)


def _copy_as_jpg(src: Path, dest: Path) -> None:
    with Image.open(src) as im:
        _save_jpg(im, dest)


def _split_grid(
    src: Path,
    dest: Path,
    *,
    rows: list[list[tuple[int, int, int, int]]],
    prefix: str = "step",
    start_index: int = 1,
) -> list[str]:
    """Crop rectangles (left, upper, right, lower) per row."""
    written: list[str] = []
    with Image.open(src) as im:
        step_no = start_index
        for row in rows:
            for box in row:
                crop = im.crop(box)
                name = f"{prefix}{step_no}.jpg"
                _save_jpg(crop, dest / name)
                written.append(name)
                step_no += 1
    return written


def prepare_pullman_bread() -> None:
    dest = _clear_dest("pullman_bread")
    _copy_as_jpg(PULLMAN_RAW / "20260525_075022.jpg", dest / "main.jpg")
    _copy_as_jpg(PULLMAN_RAW / "20260525_075031.jpg", dest / "cover.jpg")

    # 8 steps (01–08): 4×2 grid on 3000×4000 page.
    steps_1_8 = _split_grid(
        PULLMAN_RAW / "20260525_075101.jpg",
        dest,
        rows=[
            [(0, 0, 750, 2000), (750, 0, 1500, 2000), (1500, 0, 2250, 2000), (2250, 0, 3000, 2000)],
            [(0, 2000, 750, 4000), (750, 2000, 1500, 4000), (1500, 2000, 2250, 4000), (2250, 2000, 3000, 4000)],
        ],
        start_index=1,
    )

    # 7 steps (09–15): 4 on top row, 3 on bottom row.
    steps_9_15 = _split_grid(
        PULLMAN_RAW / "20260525_075108.jpg",
        dest,
        rows=[
            [(0, 0, 750, 2000), (750, 0, 1500, 2000), (1500, 0, 2250, 2000), (2250, 0, 3000, 2000)],
            [(0, 2000, 1000, 4000), (1000, 2000, 2000, 4000), (2000, 2000, 3000, 4000)],
        ],
        start_index=9,
    )

    _copy_as_jpg(PULLMAN_RAW / "20260525_075108.jpg", dest / "evaluation.jpg")
    print(f"pullman_bread: main, cover, evaluation + {len(steps_1_8) + len(steps_9_15)} steps")


def _split_steps_1_8(composite: Path, dest: Path) -> list[str]:
    return _split_grid(
        composite,
        dest,
        rows=[
            [(0, 0, 750, 2000), (750, 0, 1500, 2000), (1500, 0, 2250, 2000), (2250, 0, 3000, 2000)],
            [(0, 2000, 750, 4000), (750, 2000, 1500, 4000), (1500, 2000, 2250, 4000), (2250, 2000, 3000, 4000)],
        ],
        start_index=1,
    )


def prepare_milk_bread() -> None:
    """우유식빵: raw 폴더 없음 — 풀만 교재 01~08 분할 + 비상식빵 PNG 보조."""
    dest = _clear_dest("milk_bread")
    _copy_as_jpg(PULLMAN_RAW / "20260525_075022.jpg", dest / "main.jpg")
    _copy_as_jpg(PULLMAN_RAW / "20260525_075040.jpg", dest / "cover.jpg")

    steps = _split_steps_1_8(PULLMAN_RAW / "20260525_075101.jpg", dest)

    # 성형·팬닝·발효·완성 (step6~8 재사용 구간)
    _copy_as_jpg(EMERGENCY_RAW / "4 (2).png", dest / "step6.jpg")
    _copy_as_jpg(EMERGENCY_RAW / "4 (4).png", dest / "step7.jpg")
    chatgpt = next(EMERGENCY_RAW.glob("ChatGPT*.png"), None)
    if chatgpt:
        _copy_as_jpg(chatgpt, dest / "step8.jpg")
    else:
        shutil.copy2(dest / "step7.jpg", dest / "step8.jpg")

    print(f"milk_bread: main, cover + {len(steps)} split steps (step6-8 curated)")


def prepare_emergency_white_bread() -> None:
    dest = _clear_dest("emergency_white_bread")
    _copy_as_jpg(PULLMAN_RAW / "20260525_075026.jpg", dest / "main.jpg")
    _copy_as_jpg(PULLMAN_RAW / "20260525_075040.jpg", dest / "cover.jpg")

    steps = _split_steps_1_8(PULLMAN_RAW / "20260525_075101.jpg", dest)

    # 비상식빵 전용 성형·팬닝·발효 사진
    _copy_as_jpg(EMERGENCY_RAW / "4.png", dest / "step5.jpg")
    _copy_as_jpg(EMERGENCY_RAW / "1 (2).png", dest / "step6.jpg")
    _copy_as_jpg(EMERGENCY_RAW / "3 (2).png", dest / "step7.jpg")
    _copy_as_jpg(EMERGENCY_RAW / "2.png", dest / "step8.jpg")

    print(f"emergency_white_bread: main, cover + {len(steps)} split steps (step5-8 curated)")


def main() -> None:
    prepare_pullman_bread()
    prepare_milk_bread()
    prepare_emergency_white_bread()


if __name__ == "__main__":
    main()
