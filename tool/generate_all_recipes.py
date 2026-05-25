# -*- coding: utf-8 -*-
"""Generate RecipeDetail JSON for all raw_images products."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "assets" / "json" / "recipes"


def kp(title, items, img=None):
    imgs = {
        "시험 정보": "exam.png",
        "반죽": "mixer.png",
        "발효": "fermentation.png",
        "성형": "shaping.png",
        "굽기": "oven.png",
        "토핑": "shaping.png",
        "주요 감점 포인트": "warning.png",
    }
    return {
        "title": title,
        "imageUrl": f"assets/images/keypoints/{img or imgs.get(title, 'exam.png')}",
        "items": items,
    }


def step(rid, n, title, desc, *, tips=None, cl=None, ded=None, timers=None, calc=None, sec=300, img=None):
    folder = OUT / rid
    if img is None:
        if (folder / "step3.jpg").exists() and n <= 8:
            img = "step3.jpg"
        elif (folder / "step4.jpg").exists() and n > 8:
            img = "step4.jpg"
        elif (folder / "evaluation.jpg").exists() and n >= 13:
            img = "evaluation.jpg"
        else:
            img = "step2.jpg" if n > 4 else "step1.jpg"
    return {
        "stepNo": n,
        "title": title,
        "estimatedTimeSec": sec,
        "imageUrl": f"assets/images/recipes/{rid}/{img}",
        "description": desc if isinstance(desc, list) else [desc],
        "tips": tips or [],
        "checklist": [{"id": a, "text": b} for a, b in (cl or [])],
        "deductionPoints": [{"severity": a, "text": b} for a, b in (ded or [])],
        "timers": timers or [],
        "calculators": calc or [],
        "images": [],
    }


def ing(name, amount, cat, unit="g"):
    return {"name": name, "amount": amount, "unit": unit, "category": cat}


def build(rid, name, cat, exam, mix, oven, ferm, kps, ings, steps, evals):
    return {
        "id": rid,
        "name": name,
        "category": cat,
        "thumbnailUrl": f"assets/images/recipes/{rid}/main.jpg",
        "summary": {
            "examTimeSec": exam,
            "mixingMethod": mix,
            "oven": oven,
            "fermentation": ferm,
            "keyPoints": kps,
        },
        "ingredients": ings,
        "steps": steps,
        "resultEvaluation": [{"id": a, "text": b} for a, b in evals],
    }


def std_ferm(f=2700, b=900, s=2100, fh="75~80%", sh="85~90%"):
    d = {"first": {"temperature": 27, "humidity": fh, "timeSec": f}}
    if b:
        d["bench"] = {"temperature": "room", "timeSec": b}
    d["second"] = {"temperature": "35~40", "humidity": sh, "timeSec": s}
    return d


def std_loaf_steps(rid, divide, pan, otop, obot, bake=1800, bench=True):
    s = [
        step(rid, 1, "01. 재료 계량", ["시간 내 정확히 계량·진열."], sec=540),
        step(rid, 2, "02. 초기 믹싱", ["쇼트닝 제외 믹싱."], sec=360),
        step(rid, 3, "03. 클린업·최종 믹싱", ["클린업에 쇼트닝.", "최종 단계까지."], sec=420),
        step(rid, 4, "04. 반죽 온도", ["반죽온도 27℃."], calc=[{"type": "dough_temp", "params": {"target": 27}}], sec=60),
        step(rid, 5, "05. 1차 발효", ["27℃, 75~80%, 40~50분."], timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 3000}], sec=2700),
        step(rid, 6, "06. 분할·둥글리기", [divide], sec=600),
    ]
    n = 7
    if bench:
        s.append(step(rid, n, f"{n:02d}. 중간 발효", ["실온 10~20분."], timers=[{"type": "rest", "label": "중간 발효", "durationSec": 900}], sec=750))
        n += 1
    s += [
        step(rid, n, f"{n:02d}. 밀어펴기", ["가스 제거."], sec=180),
        step(rid, n + 1, f"{n+1:02d}. 3겹 접기", ["3겹 접기."], sec=240),
        step(rid, n + 2, f"{n+2:02d}. 말기", ["말기."], sec=180),
        step(rid, n + 3, f"{n+3:02d}. 이음매 봉합", ["봉합."], sec=120),
        step(rid, n + 4, f"{n+4:02d}. 패닝", [pan], sec=360),
        step(rid, n + 5, f"{n+5:02d}. 2차 발효", ["35~40℃, 30~40분."], timers=[{"type": "proofing", "label": "2차 발효", "durationSec": 2400}], sec=2100),
        step(rid, n + 6, f"{n+6:02d}. 굽기", [f"{otop}/{obot}℃, 30분 전후."], timers=[{"type": "baking", "label": "굽기", "durationSec": bake}], sec=bake),
    ]
    for i, st in enumerate(s, 1):
        st["stepNo"] = i
        st["title"] = st["title"].replace(f"{st['stepNo']:02d}", f"{i:02d}", 1) if False else st["title"]
    # fix titles
    titles = ["01. 재료 계량", "02. 초기 믹싱", "03. 클린업·최종 믹싱", "04. 반죽 온도", "05. 1차 발효", "06. 분할·둥글리기"]
    if bench:
        titles.append("07. 중간 발효")
    titles += ["밀어펴기", "3겹 접기", "말기", "이음매 봉합", "패닝", "2차 발효", "굽기"]
    off = 6 + (1 if bench else 0)
    for i in range(off, len(s)):
        titles.append(f"{i+1:02d}. " + titles[off + (i - off)] if i - off < 7 else "")
    # simpler: regenerate titles
    names = ["재료 계량", "초기 믹싱", "클린업·최종 믹싱", "반죽 온도", "1차 발효", "분할·둥글리기"]
    if bench:
        names.append("중간 발효")
    names += ["밀어펴기", "3겹 접기", "말기", "이음매 봉합", "패닝", "2차 발효", "굽기"]
    for i, st in enumerate(s):
        st["stepNo"] = i + 1
        st["title"] = f"{i+1:02d}. {names[i]}"
    return s


RECIPES = []  # filled below


def chestnut_bread():
    rid = "chestnut_bread"
    steps = [
        step(rid, 1, "01. 재료 계량", ["10분 내 계량·진열."], sec=600, img="step1.jpg"),
        step(rid, 2, "02. 초기 믹싱", ["쇼트닝 제외 믹싱."], img="step1.jpg"),
        step(rid, 3, "03. 클린업·최종 믹싱", ["최종 단계까지."], img="step1.jpg"),
        step(rid, 4, "04. 반죽 온도", ["27℃."], calc=[{"type": "dough_temp", "params": {"target": 27}}], img="step3.jpg"),
        step(rid, 5, "05. 1차 발효", ["40~50분."], timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 3000}], img="step3.jpg"),
        step(rid, 6, "06. 분할", ["450g×5."], img="step3.jpg"),
        step(rid, 7, "07. 둥글리기", ["둥글리기."], img="step3.jpg"),
        step(rid, 8, "08. 중간 발효", ["10~20분."], timers=[{"type": "rest", "label": "중간 발효", "durationSec": 1200}], img="step3.jpg"),
        step(rid, 9, "09. 밀어펴기", ["가스 제거."], img="step4.jpg"),
        step(rid, 10, "10. 충전", ["밤 80g."], img="step4.jpg"),
        step(rid, 11, "11. 말기", ["원로프 말기."], img="step4.jpg"),
        step(rid, 12, "12. 봉합", ["봉합."], img="step4.jpg"),
        step(rid, 13, "13. 2차 발효", ["팬닝, 2cm."], timers=[{"type": "proofing", "label": "2차 발효", "durationSec": 1800}], img="step4.jpg"),
        step(rid, 14, "14. 토핑", ["토핑 제조·바르기."], img="step4.jpg"),
        step(rid, 15, "15. 굽기", ["180/190℃, 30분."], timers=[{"type": "baking", "label": "굽기", "durationSec": 1800}], img="evaluation.jpg"),
    ]
    return build(
        rid, "밤식빵", "bread", 13200, "straight",
        {"top": 180, "bottom": 190, "unit": "celsius", "timeSec": 1800},
        std_ferm(),
        [kp("시험 정보", ["3시간 40분", "450g+밤80g×5"]), kp("반죽", ["스트레이트", "27℃"]), kp("발효", ["1차·중간·2차"]), kp("굽기", ["180/190℃"])],
        [ing("강력분", 960, "flour"), ing("중력분", 240, "flour"), ing("물", 624, "liquid"), ing("이스트", 54, "yeast"), ing("제빵개량제", 12, "improver"), ing("소금", 24, "salt"), ing("설탕", 144, "sweetener"), ing("버터", 96, "fat"), ing("탈지분유", 36, "powder"), ing("달걀", 120, "egg")],
        steps,
        [("topping_cover", "토핑이 반죽을 덮어야 함"), ("chestnut_even", "밤 고르게 분포"), ("uniform", "5개 균일")],
    )


def corn_bread():
    rid = "corn_bread"
    return build(
        rid, "옥수수식빵", "bread", 13200, "straight",
        {"top": 170, "bottom": 190, "unit": "celsius", "timeSec": 1800},
        {"first": {"temperature": 27, "humidity": "75~80%", "timeSec": 2700}, "bench": {"temperature": "room", "timeSec": 0}, "second": {"temperature": "35~40", "humidity": "85~90%", "timeSec": 1800}},
        [kp("시험 정보", ["3시간 40분", "180g×12", "4팬"])],
        [ing("강력분", 960, "flour"), ing("옥수수분말", 240, "powder"), ing("물", 720, "liquid"), ing("이스트", 36, "yeast"), ing("제빵개량제", 12, "improver"), ing("소금", 24, "salt"), ing("설탕", 96, "sweetener"), ing("쇼트닝", 84, "fat"), ing("탈지분유", 36, "powder"), ing("달걀", 60, "egg")],
        std_loaf_steps(rid, "180g×12 분할·둥글리기.", "3개씩 팬닝.", 170, 190, bench=False),
        [("uniform", "4개 균일"), ("peaks", "3봉우리")],
    )


def write_all():
    for fn in [
        chestnut_bread,
        corn_bread,
    ]:
        data = fn()
        p = OUT / f"{data['id']}.json"
        p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(p.name)


if __name__ == "__main__":
    write_all()
