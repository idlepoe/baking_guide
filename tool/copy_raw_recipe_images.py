# -*- coding: utf-8 -*-
"""Copy raw_images folders to assets/images/recipes/{id}/ with sorted naming."""
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "assets" / "raw_images"
DEST_ROOT = ROOT / "assets" / "images" / "recipes"

MAPPING = {
    "풀만": "pullman_bread",
    "밤식빵": "chestnut_bread",
    "옥수수": "corn_bread",
    "버터톱": "butter_top",
    "버터롤": "butter_roll",
    "단팥빵(스트레이트법)": "red_bean_bread",
    "단과자(트위스트형)": "pastry_twist",
    "단과자빵(소보로빵)": "soboro_bread",
    "단과자빵(크림빵)": "cream_bread",
    "모카빵": "mocha_bread",
    "그리시니": "grissini",
    "통밀빵": "whole_wheat_bread",
    "호밀빵": "rye_bread",
    "소시지빵": "sausage_bread",
    "베이글": "bagel",
    "빵도넛": "bread_donut",
    "쌀식빵": "rice_bread",
    "버터쿠키": "butter_cookie",
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


def copy_folder(korean_name: str, recipe_id: str) -> list[str]:
    src = RAW / korean_name
    dest = DEST_ROOT / recipe_id
    dest.mkdir(parents=True, exist_ok=True)
    for old in dest.glob("*.jpg"):
        old.unlink()

    files = sorted(src.glob("*.jpg"), key=lambda p: p.name)
    if not files:
        raise FileNotFoundError(f"No images in {src}")

    written: list[str] = []
    shutil.copy2(files[0], dest / "main.jpg")
    written.append("main.jpg")

    if len(files) == 1:
        shutil.copy2(files[0], dest / "step1.jpg")
        written.append("step1.jpg")
        return written

    shutil.copy2(files[1], dest / "cover.jpg")
    written.append("cover.jpg")

    if len(files) >= 5:
        shutil.copy2(files[-1], dest / "evaluation.jpg")
        written.append("evaluation.jpg")
        step_files = files[2:-1]
    else:
        step_files = files[2:]

    for i, f in enumerate(step_files, start=1):
        name = f"step{i}.jpg"
        shutil.copy2(f, dest / name)
        written.append(name)

    if not step_files:
        shutil.copy2(files[-1], dest / "step1.jpg")
        written.append("step1.jpg")

    return written


def main():
    for kr, rid in MAPPING.items():
        names = copy_folder(kr, rid)
        print(f"{rid}: {len(names)} files -> {', '.join(names)}")


if __name__ == "__main__":
    main()
