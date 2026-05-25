# -*- coding: utf-8 -*-
"""Generate RecipeDetail JSON files for baking exam recipes."""
from __future__ import annotations

import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "assets" / "json" / "recipes"
IMG = ROOT / "assets" / "images" / "recipes"


def kp(title: str, items: list[str], img: str | None = None) -> dict:
    icons = {
        "시험 정보": "exam.png",
        "반죽": "mixer.png",
        "발효": "fermentation.png",
        "성형": "shaping.png",
        "굽기": "oven.png",
        "토핑": "shaping.png",
        "튀기기": "oven.png",
        "삶기": "shaping.png",
        "주요 감점 포인트": "warning.png",
    }
    return {
        "title": title,
        "imageUrl": f"assets/images/keypoints/{img or icons.get(title, 'exam.png')}",
        "items": items,
    }


def img_for(rid: str, step_no: int, total: int) -> str:
    folder = IMG / rid
    if step_no >= total and (folder / "evaluation.jpg").exists():
        return "evaluation.jpg"
    for name in ("step3.jpg", "step2.jpg", "step1.jpg"):
        if (folder / name).exists():
            if step_no <= max(2, total // 3):
                return "step1.jpg" if (folder / "step1.jpg").exists() else name
            if step_no <= max(4, (2 * total) // 3):
                return "step2.jpg" if (folder / "step2.jpg").exists() else name
            return name
    return "main.jpg"


def step(
    rid: str,
    n: int,
    title: str,
    desc: list[str],
    *,
    total: int = 14,
    tips: list[str] | None = None,
    cl: list[tuple[str, str]] | None = None,
    ded: list[tuple[str, str]] | None = None,
    timers: list[dict] | None = None,
    calc: list[dict] | None = None,
    sec: int = 300,
    image: str | None = None,
) -> dict:
    return {
        "stepNo": n,
        "title": title,
        "estimatedTimeSec": sec,
        "imageUrl": f"assets/images/recipes/{rid}/{image or img_for(rid, n, total)}",
        "description": desc,
        "tips": tips or [],
        "checklist": [{"id": a, "text": b} for a, b in (cl or [])],
        "deductionPoints": [{"severity": a, "text": b} for a, b in (ded or [])],
        "timers": timers or [],
        "calculators": calc or [],
        "images": [],
    }


def ing(name: str, amount: float, cat: str, unit: str = "g") -> dict:
    return {"name": name, "amount": amount, "unit": unit, "category": cat}


def build(
    rid: str,
    name: str,
    cat: str,
    exam: int,
    mix: str,
    oven: dict,
    ferm: dict,
    kps: list[dict],
    ings: list[dict],
    steps: list[dict],
    evals: list[tuple[str, str]],
) -> dict:
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


def std_ferm(f: int = 2700, b: int = 900, s: int = 2100) -> dict:
    d: dict[str, Any] = {
        "first": {"temperature": 27, "humidity": "75~80%", "timeSec": f},
    }
    if b:
        d["bench"] = {"temperature": "room", "timeSec": b}
    d["second"] = {"temperature": "35~40", "humidity": "85~90%", "timeSec": s}
    return d


def weigh_step(rid: str, minutes: int, extra: list[str] | None = None, total: int = 14) -> dict:
    desc = [
        "재료를 시간 내에 정확하게 계량한다.",
        f"배합표의 각 재료를 계량하여 재료별로 진열한다 ({minutes}분).",
        "재료당 약 1분씩 계량 후 감독 위원 계량 확인을 받는다.",
        "계량 시간 초과·오계량 시 추가 시간 없이 제조 시간에 재계량한다.",
    ]
    if extra:
        desc.extend(extra)
    return step(
        rid,
        1,
        "01. 재료 계량",
        desc,
        total=total,
        sec=minutes * 60,
        cl=[
            ("weigh_complete", "재료 계량 완료"),
            ("ingredients_arranged", "재료별 진열 완료"),
            ("supervisor_check", "감독 위원 계량 확인"),
        ],
        ded=[("high", f"{minutes}분 내 계량·진열 미완료 주의"), ("medium", "계량 오차 주의")],
    )


def mix_steps(rid: str, fat: str, total: int, dough_temp: int = 27, extra_mix: str | None = None) -> list[dict]:
    s2_desc = [f"반죽은 스트레이트법으로 제조한다.", f"{fat}을(를) 제외한 모든 재료를 넣고 믹싱한다."]
    if extra_mix:
        s2_desc.append(extra_mix)
    s3_desc = [f"클린업 단계에서 {fat}을(를) 넣는다.", "최종 단계까지 믹싱한다."]
    return [
        step(
            rid,
            2,
            "02. 초기 믹싱",
            s2_desc,
            total=total,
            sec=360,
            cl=[("mix_without_fat", f"{fat} 제외 믹싱 완료")],
            ded=[("high", f"{fat} 조기 투입 주의")],
        ),
        step(
            rid,
            3,
            "03. 클린업·최종 믹싱",
            s3_desc,
            total=total,
            sec=420,
            cl=[("cleanup_stage", "클린업 단계 확인"), ("fat_added", f"{fat} 투입 완료"), ("final_stage", "최종 단계 도달")],
            ded=[("medium", "과믹싱·반죽 찢김 주의")],
        ),
        step(
            rid,
            4,
            "04. 반죽 온도",
            [f"반죽온도는 {dough_temp}℃로 한다."],
            total=total,
            sec=60,
            cl=[("dough_temp", f"반죽 온도 {dough_temp}℃ 확인")],
            calc=[{"type": "dough_temp", "params": {"target": dough_temp}}],
        ),
    ]


def first_ferm_step(rid: str, n: int, total: int, *, sec: int = 2700, label: str = "1차 발효") -> dict:
    return step(
        rid,
        n,
        f"{n:02d}. 1차 발효",
        ["온도 27℃, 습도 75~80%에서 40~50분 동안 1차 발효를 한다."],
        total=total,
        sec=sec,
        cl=[("first_fermentation_done", "1차 발효 완료")],
        ded=[("medium", "발효 부족 주의"), ("high", "과발효 주의")],
        timers=[{"type": "fermentation", "label": label, "durationSec": sec + 300}],
    )


def second_ferm_step(rid: str, n: int, total: int, desc: list[str], *, sec: int = 2100) -> dict:
    return step(
        rid,
        n,
        f"{n:02d}. 2차 발효",
        desc,
        total=total,
        sec=sec,
        cl=[("second_fermentation_done", "2차 발효 완료")],
        ded=[("high", "과발효 주의")],
        timers=[{"type": "proofing", "label": "2차 발효", "durationSec": sec + 300}],
    )


def bake_step(rid: str, n: int, total: int, top: int, bot: int, time_sec: int, desc: list[str]) -> dict:
    return step(
        rid,
        n,
        f"{n:02d}. 굽기",
        desc,
        total=total,
        sec=time_sec,
        cl=[("baking_done", "굽기 완료")],
        ded=[("high", "과색 주의"), ("medium", "미숙성 주의")],
        timers=[{"type": "baking", "label": "굽기", "durationSec": time_sec}],
        image="evaluation.jpg" if (IMG / rid / "evaluation.jpg").exists() else None,
    )


def butter_top() -> dict:
    rid = "butter_top"
    total = 15
    steps = [
        weigh_step(rid, 9, total=total),
        *mix_steps(rid, "버터", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["460g으로 5개 모두 분할한 후 둥글리기 한다.", "반죽 전량을 사용한다 (460g×1 = 1개 식빵, 총 5개)."], total=total, sec=600, cl=[("divide_5", "460g×5개 분할·둥글리기 완료")], calc=[{"type": "division_weight", "params": {"target": 460}}]),
        step(rid, 7, "07. 중간 발효", ["실온에서 10~20분 동안 중간 발효를 한다."], total=total, sec=900, timers=[{"type": "rest", "label": "중간 발효", "durationSec": 1200}]),
        step(rid, 8, "08. 밀어펴기", ["밀대로 반죽을 밀어 펴 가스를 뺀다."], total=total, sec=180),
        step(rid, 9, "09. 3겹 접기", ["3겹 접기를 5개 모두 진행한다."], total=total, sec=240),
        step(rid, 10, "10. 말기", ["끝부분부터 반죽을 말아준다."], total=total, sec=180),
        step(rid, 11, "11. 이음매 봉합", ["이음매 부분이 터지지 않도록 잘 봉합한다."], total=total, sec=120, ded=[("high", "이음매 터짐·벌어짐 주의")]),
        step(rid, 12, "12. 패닝", ["이음매가 바닥으로 향하게 1개씩 팬닝한다."], total=total, sec=300),
        step(rid, 13, "13. 칼집·버터", ["윗면을 칼로 길게 칼집을 내고 버터(바르기용 60g)를 짜 넣는다."], total=total, sec=180, cl=[("score_butter", "칼집·버터 완료")], ded=[("high", "칼집·버터 누락 주의")]),
        second_ferm_step(rid, 14, total, ["35~40℃, 85~90%에서 30분 전후 2차 발효.", "반죽이 팬 위로 약 2cm 아래까지 올라오면 완료."]),
        bake_step(rid, 15, total, 180, 190, 1800, ["윗불 180℃, 아랫불 190℃에서 30분 전후로 굽는다.", "식빵 5개를 균일하게 굽는다."]),
    ]
    return build(
        rid, "버터톱 식빵", "bread", 12600, "straight",
        {"top": 180, "bottom": 190, "unit": "celsius", "timeSec": 1800},
        std_ferm(s=1800),
        [
            kp("시험 정보", ["시험 시간: 3시간 30분", "재료 계량: 9분", "스트레이트법", "460g×5개, 칼집+버터"]),
            kp("반죽", ["버터 제외 믹싱 → 클린업에 버터", "최종 단계까지", "반죽 온도 27℃"]),
            kp("발효", ["1차: 27℃, 40~50분", "중간: 실온 10~20분", "2차: 35~40℃, 30분 (팬 위 2cm 아래)"]),
            kp("성형", ["3겹 접기 → 말기 → 봉합", "윗면 칼집 후 버터(바르기용)"]),
            kp("굽기", ["180/190℃", "30분 전후"]),
            kp("주요 감점 포인트", ["5개 부피·색 불균일", "칼집·버터 누락", "과발효·과색"]),
        ],
        [
            ing("강력분", 1200, "flour"), ing("물", 480, "liquid"), ing("이스트", 48, "yeast"),
            ing("제빵개량제", 12, "improver"), ing("소금", 21.6, "salt"), ing("설탕", 72, "sweetener"),
            ing("버터", 240, "fat"), ing("탈지분유", 36, "powder"), ing("달걀", 240, "egg"),
            ing("버터(바르기용)", 60, "fat"),
        ],
        steps,
        [("uniform_five", "5개 식빵이 균일한 부피·색이어야 한다."), ("score_butter", "윗면 칼집에 버터가 고르게 들어가야 한다."), ("no_burst", "옆면·이음매 터짐이 없어야 한다.")],
    )


def butter_roll() -> dict:
    rid = "butter_roll"
    total = 13
    steps = [
        weigh_step(rid, 9, total=total),
        *mix_steps(rid, "버터", total, extra_mix="버터가 많으므로 나누어 넣으면 믹싱 시간을 줄일 수 있다."),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["50g씩 24개로 분할한 후 둥글리기 한다."], total=total, sec=720, cl=[("divide_24", "50g×24개 분할·둥글리기")], calc=[{"type": "division_weight", "params": {"target": 50}}]),
        step(rid, 7, "07. 중간 발효", ["실온에서 10~20분 중간 발효."], total=total, sec=900, timers=[{"type": "rest", "label": "중간 발효", "durationSec": 1200}]),
        step(rid, 8, "08. 성형", ["번데기 모양(쐐기형)으로 성형한다.", "24개 모두 동일하게 성형한다."], total=total, sec=900, cl=[("shape_24", "번데기형 24개 성형")]),
        second_ferm_step(rid, 9, total, ["35~40℃, 85~90%에서 25~30분 2차 발효."], sec=1650),
        bake_step(rid, 10, total, 200, 140, 660, ["윗불 200℃, 아랫불 140~150℃에서 10~12분 굽는다."]),
    ]
    return build(
        rid, "버터롤", "bread", 12600, "straight",
        {"top": 200, "bottom": 140, "unit": "celsius", "timeSec": 660},
        std_ferm(s=1650, b=900),
        [
            kp("시험 정보", ["3시간 30분", "50g×24개", "번데기형"]),
            kp("반죽", ["버터 클린업 투입", "27℃"]),
            kp("발효", ["1차 40~50분", "2차 25~30분"]),
            kp("굽기", ["200/140~150℃", "10~12분"]),
            kp("주요 감점 포인트", ["24개 미달 실격", "형태·색 불균일"]),
        ],
        [
            ing("강력분", 900, "flour"), ing("설탕", 90, "sweetener"), ing("소금", 18, "salt"),
            ing("버터", 135, "fat"), ing("탈지분유", 27, "powder"), ing("달걀", 72, "egg"),
            ing("이스트", 36, "yeast"), ing("제빵개량제", 9, "improver"), ing("물", 477, "liquid"),
        ],
        steps,
        [("count_24", "50g×24개가 모두 제출되어야 한다."), ("chrysalis_shape", "번데기형이 균일해야 한다."), ("golden_gloss", "황금색·윤기가 균일해야 한다.")],
    )


def red_bean_bread() -> dict:
    rid = "red_bean_bread"
    total = 12
    steps = [
        weigh_step(rid, 9, ["충전재(통팥앙금)는 계량 시간에서 제외한다."], total=total),
        step(rid, 2, "02. 초기 믹싱", ["비상스트레이트법으로 제조한다.", "마가린을 제외한 모든 재료를 넣고 믹싱한다."], total=total, sec=360),
        step(rid, 3, "03. 클린업·과믹싱", ["클린업 단계에서 마가린을 넣는다.", "최종 단계보다 20~25% 더 믹싱한다."], total=total, sec=480, cl=[("overmix", "과믹싱(20~25%) 완료")]),
        step(rid, 4, "04. 반죽 온도", ["반죽온도는 30℃로 한다."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 30}}]),
        step(rid, 5, "05. 1차 발효", ["온도 30℃, 습도 75~80%에서 15~30분 1차 발효."], total=total, sec=1350, timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 1800}]),
        step(rid, 6, "06. 분할·둥글리기", ["50g씩 24개 분할·둥글리기."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 50}}]),
        step(rid, 7, "07. 충전", ["각 반죽에 통팥앙금 40g을 충전한다."], total=total, sec=720, cl=[("fill_40g", "40g 충전 완료")]),
        step(rid, 8, "08. 봉합·성형", ["이음매를 단단히 봉합하고 배꼽 모양으로 성형한다."], total=total, sec=600, ded=[("high", "팥 노출·터짐 주의")]),
        second_ferm_step(rid, 9, total, ["35~40℃, 85~90%에서 20~30분 2차 발효.", "발효 후 윗면을 살짝 건조시킨 뒤 중앙을 손가락으로 다시 눌러준다."], sec=1500),
        bake_step(rid, 10, total, 190, 170, 750, ["190/170℃에서 10~15분 굽는다."]),
    ]
    return build(
        rid, "단팥빵", "bread", 10800, "emergency_straight",
        {"top": 190, "bottom": 170, "unit": "celsius", "timeSec": 750},
        {"first": {"temperature": 30, "humidity": "75~80%", "timeSec": 1350}, "second": {"temperature": "35~40", "humidity": "85~90%", "timeSec": 1500}},
        [
            kp("시험 정보", ["3시간", "비상스트레이트법", "50g+40g×24"]),
            kp("반죽", ["30℃", "최종단계 20~25% 과믹싱"]),
            kp("발효", ["1차 15~30분", "2차 20~30분"]),
            kp("성형", ["배꼽 모양", "팥 중앙 배치"]),
            kp("주요 감점 포인트", ["팥 노출·편향", "24개 미달"]),
        ],
        [
            ing("강력분", 900, "flour"), ing("물", 432, "liquid"), ing("이스트", 63, "yeast"),
            ing("제빵개량제", 9, "improver"), ing("소금", 18, "salt"), ing("설탕", 144, "sweetener"),
            ing("마가린", 108, "fat"), ing("탈지분유", 27, "powder"), ing("달걀", 135, "egg"),
            ing("통팥앙금", 960, "filling"),
        ],
        steps,
        [("belly_button", "배꼽 모양 중앙이 선명하고 대비가 있어야 한다."), ("no_leak", "밑면·옆면에서 팥이 보이지 않아야 한다."), ("round_volume", "둥글고 두툼한 부피여야 한다.")],
    )


def pastry_twist() -> dict:
    rid = "pastry_twist"
    total = 12
    steps = [
        weigh_step(rid, 9, total=total),
        *mix_steps(rid, "쇼트닝", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["50g씩 24개 분할·둥글리기."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 50}}]),
        step(rid, 7, "07. 중간 발효", ["실온 10~20분."], total=total, sec=900, timers=[{"type": "rest", "label": "중간 발효", "durationSec": 1200}]),
        step(rid, 8, "08. 8자형 성형", ["12개를 8자형으로 성형한다."], total=total, sec=480, cl=[("figure8_12", "8자형 12개 완료")]),
        step(rid, 9, "09. 달팽이형 성형", ["12개를 달팽이형으로 성형한다."], total=total, sec=480, cl=[("snail_12", "달팽이형 12개 완료")]),
        second_ferm_step(rid, 10, total, ["35~40℃, 85~90%에서 25~30분 2차 발효."], sec=1650),
        bake_step(rid, 11, total, 200, 150, 660, ["200/150℃에서 10~12분 굽는다."]),
    ]
    return build(
        rid, "단과자 트위스트", "pastry", 12600, "straight",
        {"top": 200, "bottom": 150, "unit": "celsius", "timeSec": 660},
        std_ferm(s=1650),
        [
            kp("시험 정보", ["3시간 30분", "50g×24", "8자 12 + 달팽이 12"]),
            kp("반죽", ["쇼트닝 클린업", "27℃"]),
            kp("성형", ["8자형·달팽이형 각 12개"]),
            kp("굽기", ["200/150℃", "10~12분"]),
            kp("주요 감점 포인트", ["형태·개수 미달 실격"]),
        ],
        [
            ing("강력분", 900, "flour"), ing("물", 422, "liquid"), ing("이스트", 36, "yeast"),
            ing("제빵개량제", 8, "improver"), ing("소금", 18, "salt"), ing("설탕", 108, "sweetener"),
            ing("쇼트닝", 90, "fat"), ing("분유", 26, "powder"), ing("달걀", 180, "egg"),
        ],
        steps,
        [("figure8_12", "8자형 12개가 균일해야 한다."), ("snail_12", "달팽이형 12개가 균일해야 한다."), ("golden_even", "색·광택이 균일해야 한다.")],
    )


def soboro_bread() -> dict:
    rid = "soboro_bread"
    total = 13
    steps = [
        weigh_step(rid, 9, ["소보로 토핑 재료는 계량 시간에서 제외할 수 있다."], total=total),
        *mix_steps(rid, "마가린", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 소보로 토핑", ["배합표에 따라 소보로 토핑을 직접 제조한다."], total=total, sec=600, cl=[("soboro_ready", "소보로 토핑 완료")]),
        step(rid, 7, "07. 분할·둥글리기", ["50g씩 24개 분할·둥글리기."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 50}}]),
        step(rid, 8, "08. 토핑", ["각 반죽 위에 소보로 30g씩 올린다."], total=total, sec=480, cl=[("topping_30g", "30g 토핑 완료")]),
        second_ferm_step(rid, 9, total, ["35~40℃, 85~90%에서 20~25분 2차 발효."], sec=1350),
        bake_step(rid, 10, total, 190, 160, 810, ["190/160℃에서 12~15분 굽는다."]),
    ]
    return build(
        rid, "소보로빵", "pastry", 12600, "straight",
        {"top": 190, "bottom": 160, "unit": "celsius", "timeSec": 810},
        std_ferm(s=1350),
        [
            kp("시험 정보", ["3시간 30분", "50g+30g 토핑×24", "단과자"]),
            kp("토핑", ["소보로 직접 제조", "반죽당 30g"]),
            kp("굽기", ["190/160℃", "12~15분"]),
            kp("주요 감점 포인트", ["토핑 균일·균열"]),
        ],
        [
            ing("강력분", 900, "flour"), ing("물", 423, "liquid"), ing("이스트", 36, "yeast"),
            ing("제빵개량제", 9, "improver"), ing("소금", 18, "salt"), ing("마가린", 162, "fat"),
            ing("탈지분유", 18, "powder"), ing("달걀", 135, "egg"), ing("설탕", 144, "sweetener"),
            ing("중력분(토핑)", 300, "flour"), ing("설탕(토핑)", 180, "sweetener"),
            ing("마가린(토핑)", 150, "fat"), ing("땅콩버터", 45, "filling"),
            ing("달걀(토핑)", 30, "egg"), ing("물엿", 30, "sweetener"),
            ing("탈지분유(토핑)", 9, "powder"), ing("베이킹파우더", 6, "powder"), ing("소금(토핑)", 3, "salt"),
        ],
        steps,
        [("soboro_cover", "소보로가 반죽을 고르게 덮어야 한다."), ("crack_pattern", "균열 무늬가 균일해야 한다."), ("count_24", "24개가 균일해야 한다.")],
    )


def cream_bread() -> dict:
    rid = "cream_bread"
    total = 13
    steps = [
        weigh_step(rid, 9, ["충전용 커스터드 크림은 계량 시간에서 제외."], total=total),
        *mix_steps(rid, "쇼트닝", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["46g씩 24개 분할·둥글리기."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 46}}]),
        step(rid, 7, "07. 충전형 12개", ["12개에 커스터드 크림 30g씩 충전·봉합한다."], total=total, sec=600, cl=[("cream_12", "충전형 12개 완료")]),
        step(rid, 8, "08. 반달형 12개", ["12개는 크림 없이 반달형으로 성형한다."], total=total, sec=480, cl=[("half_moon_12", "반달형 12개 완료")]),
        second_ferm_step(rid, 9, total, ["35~40℃, 85~90%에서 30~40분 2차 발효."], sec=2100),
        bake_step(rid, 10, total, 200, 150, 660, ["200/150℃에서 10~12분 굽는다."]),
    ]
    return build(
        rid, "크림빵", "pastry", 12600, "straight",
        {"top": 200, "bottom": 150, "unit": "celsius", "timeSec": 660},
        std_ferm(s=2100),
        [
            kp("시험 정보", ["3시간 30분", "46g×24", "충전 12 + 반달 12"]),
            kp("성형", ["충전형 12", "반달형 12"]),
            kp("굽기", ["200/150℃", "10~12분"]),
            kp("주요 감점 포인트", ["형태·개수 미달"]),
        ],
        [
            ing("강력분", 800, "flour"), ing("물", 424, "liquid"), ing("이스트", 32, "yeast"),
            ing("제빵개량제", 16, "improver"), ing("소금", 16, "salt"), ing("설탕", 128, "sweetener"),
            ing("쇼트닝", 96, "fat"), ing("분유", 16, "powder"), ing("달걀", 80, "egg"),
            ing("커스터드 크림", 360, "filling"),
        ],
        steps,
        [("cream_12", "충전형 12개가 균일해야 한다."), ("half_moon_12", "반달형 12개가 균일해야 한다."), ("no_leak", "크림 누출이 없어야 한다.")],
    )


def mocha_bread() -> dict:
    rid = "mocha_bread"
    total = 14
    steps = [
        weigh_step(rid, 11, ["토핑용 비스킷 재료 포함 11분."], total=total),
        *mix_steps(rid, "버터", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 비스킷 토핑", ["배합표에 따라 토핑용 비스킷 반죽을 제조한다."], total=total, sec=600, cl=[("biscuit_ready", "비스킷 토핑 완료")]),
        step(rid, 7, "07. 분할", ["반죽 250g×6, 비스킷 100g×6으로 분할."], total=total, sec=480, cl=[("divide_dough", "250g×6 분할"), ("divide_biscuit", "100g×6 분할")]),
        step(rid, 8, "08. 성형·토핑", ["타원형(럭비공)으로 성형하고 비스킷 토핑을 올린다."], total=total, sec=600),
        second_ferm_step(rid, 9, total, ["35~40℃, 85~90%에서 30분 전후 2차 발효."], sec=1800),
        bake_step(rid, 10, total, 190, 160, 1650, ["190/160℃에서 25~30분 굽는다."]),
    ]
    return build(
        rid, "모카빵", "hard", 12600, "straight",
        {"top": 190, "bottom": 160, "unit": "celsius", "timeSec": 1650},
        std_ferm(s=1800),
        [
            kp("시험 정보", ["3시간 30분", "250g+100g 비스킷×6"]),
            kp("비스킷 토핑", ["비스킷 직접 제조", "100g씩 올리기"]),
            kp("성형", ["타원형", "건포도 포함"]),
            kp("굽기", ["190/160℃", "25~30분"]),
            kp("주요 감점 포인트", ["비스킷 균열·건포도 분포"]),
        ],
        [
            ing("강력분", 850, "flour"), ing("물", 382, "liquid"), ing("이스트", 42, "yeast"),
            ing("제빵개량제", 8, "improver"), ing("소금", 16, "salt"), ing("설탕", 128, "sweetener"),
            ing("버터", 102, "fat"), ing("탈지분유", 26, "powder"), ing("달걀", 86, "egg"),
            ing("인스턴트커피", 12, "powder"), ing("건포도", 128, "filling"),
            ing("박력분(비스킷)", 350, "flour"), ing("버터(비스킷)", 70, "fat"),
            ing("설탕(비스킷)", 140, "sweetener"), ing("달걀(비스킷)", 84, "egg"),
            ing("베이킹파우더", 5, "powder"), ing("우유", 42, "liquid"), ing("소금(비스킷)", 2, "salt"),
        ],
        steps,
        [("tiger_crack", "비스킷 토핑 균열이 균일해야 한다."), ("raisin_even", "건포도가 고르게 분포해야 한다."), ("coffee_crumb", "커피색 조직이 균일해야 한다.")],
    )


def grissini() -> dict:
    rid = "grissini"
    total = 11
    steps = [
        weigh_step(rid, 8, total=total),
        step(rid, 2, "02. 믹싱", ["모든 재료를 한 번에 넣고 스트레이트법으로 믹싱한다.", "발전 단계까지 믹싱한다."], total=total, sec=480, cl=[("development_stage", "발전 단계 도달")]),
        step(rid, 3, "03. 반죽 온도", ["반죽온도 27℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 27}}]),
        step(rid, 4, "04. 1차 발효", ["27℃, 75~80%에서 15~30분 1차 발효."], total=total, sec=1350, timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 1800}]),
        step(rid, 5, "05. 분할·둥글리기", ["30g씩 분할·둥글리기. 반죽 전량 사용."], total=total, sec=900, calc=[{"type": "division_weight", "params": {"target": 30}}]),
        step(rid, 6, "06. 막대 성형", ["35~40cm 길이의 막대 모양으로 성형한다."], total=total, sec=1200, cl=[("stick_shape", "35~40cm 막대 성형")]),
        second_ferm_step(rid, 7, total, ["35~40℃, 85~90%에서 20분 전후 2차 발효."], sec=1200),
        bake_step(rid, 8, total, 200, 150, 1050, ["200/150℃에서 15~20분 굽는다."]),
    ]
    return build(
        rid, "그리시니", "hard", 9000, "straight",
        {"top": 200, "bottom": 150, "unit": "celsius", "timeSec": 1050},
        {"first": {"temperature": 27, "humidity": "75~80%", "timeSec": 1350}, "second": {"temperature": "35~40", "humidity": "85~90%", "timeSec": 1200}},
        [
            kp("시험 정보", ["2시간 30분", "30g 막대 35~40cm"]),
            kp("반죽", ["일괄 투입", "발전 단계", "27℃"]),
            kp("발효", ["1차 15~30분", "2차 20분"]),
            kp("굽기", ["200/150℃", "15~20분"]),
            kp("주요 감점 포인트", ["길이·두께 불균일"]),
        ],
        [
            ing("강력분", 700, "flour"), ing("설탕", 7, "sweetener"), ing("건조 로즈마리", 1, "spice"),
            ing("소금", 14, "salt"), ing("이스트", 21, "yeast"), ing("버터", 84, "fat"),
            ing("올리브유", 14, "fat"), ing("물", 434, "liquid"),
        ],
        steps,
        [("length_uniform", "35~40cm 길이가 균일해야 한다."), ("crisp_texture", "바삭한 식감이어야 한다."), ("light_golden", "균일한 연한 황금색이어야 한다.")],
    )


def whole_wheat_bread() -> dict:
    rid = "whole_wheat_bread"
    total = 12
    steps = [
        weigh_step(rid, 10, ["오트밀(200g)은 계량 시간에서 제외."], total=total),
        *mix_steps(rid, "버터", total, dough_temp=25, extra_mix="발전 단계까지 믹싱한다."),
        step(rid, 4, "04. 반죽 온도", ["반죽온도 25℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 25}}]),
        step(rid, 5, "05. 1차 발효", ["27℃, 75~80%에서 50~60분 1차 발효."], total=total, sec=3300, timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 3600}]),
        step(rid, 6, "06. 분할·둥글리기", ["200g씩 8개 분할·둥글리기."], total=total, sec=480, calc=[{"type": "division_weight", "params": {"target": 200}}]),
        step(rid, 7, "07. 성형", ["밀대 모양(22~23cm)으로 성형한다."], total=total, sec=600, cl=[("stick_shape", "22~23cm 성형")]),
        step(rid, 8, "08. 오트밀 토핑", ["표면에 물을 바르고 오트밀을 고르게 묻힌다."], total=total, sec=300, cl=[("oat_topping", "오트밀 토핑 완료")]),
        second_ferm_step(rid, 9, total, ["35~40℃, 85~90%에서 30~40분 2차 발효."], sec=2100),
        bake_step(rid, 10, total, 190, 160, 1200, ["190/160℃에서 20분 전후 굽는다."]),
    ]
    # fix step numbers after custom mix
    steps[3] = step(rid, 4, "04. 반죽 온도", ["반죽온도 25℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 25}}])
    steps = [
        weigh_step(rid, 10, ["오트밀(200g)은 계량 시간에서 제외."], total=total),
        step(rid, 2, "02. 초기 믹싱", ["스트레이트법. 버터 제외 믹싱."], total=total, sec=360),
        step(rid, 3, "03. 클린업·발전 믹싱", ["클린업에 버터.", "발전 단계까지 믹싱."], total=total, sec=480),
        step(rid, 4, "04. 반죽 온도", ["25℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 25}}]),
        step(rid, 5, "05. 1차 발효", ["50~60분."], total=total, sec=3300, timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 3600}]),
        step(rid, 6, "06. 분할·둥글리기", ["200g×8."], total=total, sec=480, calc=[{"type": "division_weight", "params": {"target": 200}}]),
        step(rid, 7, "07. 성형", ["22~23cm 밀대형."], total=total, sec=600),
        step(rid, 8, "08. 오트밀 토핑", ["물 바르기 → 오트밀."], total=total, sec=300, cl=[("oat_topping", "오트밀 토핑")]),
        second_ferm_step(rid, 9, total, ["30~40분 2차 발효."], sec=2100),
        bake_step(rid, 10, total, 190, 160, 1200, ["190/160℃, 20분."]),
    ]
    return build(
        rid, "통밀빵", "hard", 12600, "straight",
        {"top": 190, "bottom": 160, "unit": "celsius", "timeSec": 1200},
        {"first": {"temperature": 27, "humidity": "75~80%", "timeSec": 3300}, "second": {"temperature": "35~40", "humidity": "85~90%", "timeSec": 2100}},
        [
            kp("시험 정보", ["3시간 30분", "200g×8", "오트밀 토핑"]),
            kp("반죽", ["25℃", "발전 단계"]),
            kp("성형", ["22~23cm", "물+오트밀"]),
            kp("굽기", ["190/160℃", "20분"]),
            kp("주요 감점 포인트", ["오트밀 불균일", "길이 불균일"]),
        ],
        [
            ing("강력분", 800, "flour"), ing("통밀가루", 200, "flour"), ing("이스트", 25, "yeast"),
            ing("제빵개량제", 10, "improver"), ing("물", 640, "liquid"), ing("소금", 15, "salt"),
            ing("설탕", 30, "sweetener"), ing("버터", 70, "fat"), ing("탈지분유", 20, "powder"),
            ing("몰트액", 15, "liquid"), ing("오트밀", 200, "filling"),
        ],
        steps,
        [("oat_even", "오트밀이 고르게 묻어야 한다."), ("length_22", "22~23cm 길이가 균일해야 한다."), ("whole_wheat_crumb", "통밀 조직이 균일해야 한다.")],
    )


def rye_bread() -> dict:
    rid = "rye_bread"
    total = 13
    steps = [
        weigh_step(rid, 10, total=total),
        step(rid, 2, "02. 초기 믹싱", ["스트레이트법. 쇼트닝 제외."], total=total, sec=360),
        step(rid, 3, "03. 클린업·발전 믹싱", ["클린업에 쇼트닝.", "발전 단계까지."], total=total, sec=480),
        step(rid, 4, "04. 반죽 온도", ["25℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 25}}]),
        step(rid, 5, "05. 1차 발효", ["27℃, 75~80%에서 70~90분."], total=total, sec=4800, timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 5400}]),
        step(rid, 6, "06. 분할·둥글리기", ["330g×6."], total=total, sec=480, calc=[{"type": "division_weight", "params": {"target": 330}}]),
        step(rid, 7, "07. 성형", ["타원형(럭비공)으로 성형."], total=total, sec=600),
        step(rid, 8, "08. 칼집·분무", ["윗면에 일자 칼집.", "분무(스프레이) 처리."], total=total, sec=180, cl=[("slash_spray", "칼집·분무 완료")]),
        second_ferm_step(rid, 9, total, ["30~40분 2차 발효."], sec=2100),
        step(rid, 10, "10. 1차 굽기", ["190/180℃에서 10분 굽는다."], total=total, sec=600, timers=[{"type": "baking", "label": "1차 굽기", "durationSec": 600}]),
        step(rid, 11, "11. 2차 굽기", ["180/160℃로 낮춰 15~20분 더 굽는다."], total=total, sec=1050, timers=[{"type": "baking", "label": "2차 굽기", "durationSec": 1200}], image="evaluation.jpg" if (IMG / rid / "evaluation.jpg").exists() else None),
    ]
    return build(
        rid, "호밀빵", "hard", 12600, "straight",
        {"top": 190, "bottom": 180, "unit": "celsius", "timeSec": 1650},
        {"first": {"temperature": 27, "humidity": "75~80%", "timeSec": 4800}, "second": {"temperature": "35~40", "humidity": "85~90%", "timeSec": 2100}},
        [
            kp("시험 정보", ["3시간 30분", "330g×6", "2단계 굽기"]),
            kp("반죽", ["25℃", "발전 단계"]),
            kp("칼집·성형", ["일자 칼집", "분무", "타원형"]),
            kp("굽기", ["190/180→180/160", "10분+15~20분"]),
            kp("주요 감점 포인트", ["칼집·발색 불균일"]),
        ],
        [
            ing("강력분", 770, "flour"), ing("호밀가루", 330, "flour"), ing("이스트", 33, "yeast"),
            ing("제빵개량제", 11, "improver"), ing("물", 688, "liquid"), ing("소금", 22, "salt"),
            ing("황설탕", 33, "sweetener"), ing("쇼트닝", 55, "fat"), ing("탈지분유", 22, "powder"),
            ing("몰트액", 22, "liquid"),
        ],
        steps,
        [("center_slash", "중앙 일자 칼집이 선명해야 한다."), ("two_stage_bake", "2단계 굽기로 균일한 발색."), ("oval_uniform", "6개 타원형이 균일해야 한다.")],
    )


def sausage_bread() -> dict:
    rid = "sausage_bread"
    total = 12
    steps = [
        weigh_step(rid, 10, ["토핑·충전물은 1차 발효 중 준비."], total=total),
        *mix_steps(rid, "마가린", total),
        step(rid, 5, "05. 1차 발효·토핑 준비", ["27℃, 40~50분 1차 발효.", "발효 중 토핑·충전물(소시지·양파·치즈·케첩·마요) 준비."], total=total, sec=2700, timers=[{"type": "fermentation", "label": "1차 발효", "durationSec": 3000}], cl=[("topping_prep", "토핑 준비 완료")]),
        step(rid, 6, "06. 분할·둥글리기", ["70g×12."], total=total, sec=480, calc=[{"type": "division_weight", "params": {"target": 70}}]),
        step(rid, 7, "07. 성형", ["낙엽형 6개, 꽃잎형 6개로 성형·토핑."], total=total, sec=900, cl=[("leaf_6", "낙엽형 6"), ("flower_6", "꽃잎형 6")]),
        second_ferm_step(rid, 8, total, ["20~30분 2차 발효."], sec=1500),
        bake_step(rid, 9, total, 190, 160, 1050, ["190/160℃, 15~20분."]),
    ]
    return build(
        rid, "소시지빵", "bread", 12600, "straight",
        {"top": 190, "bottom": 160, "unit": "celsius", "timeSec": 1050},
        std_ferm(s=1500),
        [
            kp("시험 정보", ["3시간 30분", "70g×12", "낙엽 6+꽃잎 6"]),
            kp("토핑", ["1차 발효 중 준비", "소시지·양파·치즈·케첩·마요"]),
            kp("굽기", ["190/160℃", "15~20분"]),
            kp("주요 감점 포인트", ["형태·토핑 불균일"]),
        ],
        [
            ing("강력분", 560, "flour"), ing("중력분", 140, "flour"), ing("생이스트", 28, "yeast"),
            ing("제빵개량제", 6, "improver"), ing("소금", 14, "salt"), ing("설탕", 76, "sweetener"),
            ing("마가린", 62, "fat"), ing("탈지분유", 34, "powder"), ing("달걀", 34, "egg"), ing("물", 364, "liquid"),
            ing("프랑크소시지", 480, "filling"), ing("양파", 336, "filling"), ing("마요네즈", 158, "filling"),
            ing("피자치즈", 102, "filling"), ing("케첩", 112, "filling"),
        ],
        steps,
        [("leaf_flower", "낙엽형·꽃잎형 각 6개."), ("topping_even", "토핑이 고르게 올라가야 한다."), ("golden_brown", "황금색 균일.")],
    )


def bagel() -> dict:
    rid = "bagel"
    total = 12
    steps = [
        weigh_step(rid, 7, total=total),
        step(rid, 2, "02. 믹싱", ["모든 재료 일괄 투입.", "발전 단계까지 믹싱."], total=total, sec=480),
        step(rid, 3, "03. 반죽 온도", ["27℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 27}}]),
        first_ferm_step(rid, 4, total),
        step(rid, 5, "05. 분할·둥글리기", ["80g×16."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 80}}]),
        step(rid, 6, "06. 고리 성형", ["고리 모양으로 성형. 2팬(16개)."], total=total, sec=720, cl=[("ring_16", "고리형 16개")]),
        second_ferm_step(rid, 7, total, ["15~20분 2차 발효."], sec=1050),
        step(rid, 8, "08. 삶기", ["2차 발효 후 끓는 물에 데친다.", "데친 후 팬닝·짧은 추가 발효."], total=total, sec=480, cl=[("boil_done", "삶기 완료")], ded=[("high", "삶기 누락 주의")]),
        bake_step(rid, 9, total, 200, 170, 1140, ["200/170℃, 18~20분."]),
    ]
    return build(
        rid, "베이글", "bread", 12600, "straight",
        {"top": 200, "bottom": 170, "unit": "celsius", "timeSec": 1140},
        std_ferm(s=1050),
        [
            kp("시험 정보", ["3시간 30분", "80g×16", "2팬"]),
            kp("반죽", ["일괄 투입", "발전 단계"]),
            kp("삶기", ["2차 발효 후 끓는물 데치기"]),
            kp("굽기", ["200/170℃", "18~20분"]),
            kp("주요 감점 포인트", ["16개 미달", "광택·고리 불균일"]),
        ],
        [
            ing("강력분", 800, "flour"), ing("물", 460, "liquid"), ing("이스트", 24, "yeast"),
            ing("제빵개량제", 8, "improver"), ing("소금", 16, "salt"), ing("설탕", 16, "sweetener"),
            ing("식용유", 24, "fat"),
        ],
        steps,
        [("ring_16", "고리형 16개."), ("glossy_crust", "윤기 있는 껍질."), ("even_color", "색·크기 균일.")],
    )


def bread_donut() -> dict:
    rid = "bread_donut"
    total = 11
    steps = [
        weigh_step(rid, 12, total=total),
        *mix_steps(rid, "쇼트닝", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["46g×44."], total=total, sec=900, calc=[{"type": "division_weight", "params": {"target": 46}}]),
        step(rid, 7, "07. 성형", ["8자형 22개, 트위스트형 22개 성형."], total=total, sec=900, cl=[("figure8_22", "8자 22"), ("twist_22", "트위스트 22")]),
        second_ferm_step(rid, 8, total, ["25~30분 2차 발효."], sec=1650),
        step(
            rid, 9, "09. 튀기기",
            ["기름온도 180~185℃에서 튀긴 후 설탕을 묻힌다.", "오븐이 아닌 튀김으로 완성한다."],
            total=total, sec=900,
            cl=[("fry_done", "튀기기 완료"), ("sugar_coat", "설탕 코팅")],
            ded=[("high", "기름온도·과튀김 주의")],
            timers=[{"type": "baking", "label": "튀기기", "durationSec": 900}],
        ),
    ]
    return build(
        rid, "빵도넛", "specialty", 10800, "straight",
        {"top": 180, "bottom": 185, "unit": "celsius", "timeSec": 900},
        std_ferm(s=1650),
        [
            kp("시험 정보", ["3시간", "46g×44", "8자 22+트위스트 22"]),
            kp("튀기기", ["180~185℃", "오븐 아님", "설탕 코팅"]),
            kp("주요 감점 포인트", ["개수·형태 미달", "과튀김"]),
        ],
        [
            ing("강력분", 880, "flour"), ing("박력분", 220, "flour"), ing("설탕", 110, "sweetener"),
            ing("쇼트닝", 132, "fat"), ing("소금", 16.5, "salt"), ing("탈지분유", 33, "powder"),
            ing("이스트", 55, "yeast"), ing("제빵개량제", 11, "improver"), ing("바닐라향", 2.2, "spice"),
            ing("달걀", 165, "egg"), ing("물", 506, "liquid"), ing("넛메그", 2.2, "spice"),
        ],
        steps,
        [("count_44", "44개(8자 22+트위스트 22)."), ("golden_fry", "균일한 황금색."), ("sugar_even", "설탕 코팅 균일.")],
    )


def rice_bread() -> dict:
    rid = "rice_bread"
    total = 14
    steps = [
        weigh_step(rid, 9, total=total),
        step(rid, 2, "02. 초기 믹싱", ["쇼트닝 제외 믹싱."], total=total, sec=360),
        step(rid, 3, "03. 클린업·발전 후기", ["클린업에 쇼트닝.", "발전 단계 후기까지."], total=total, sec=480),
        step(rid, 4, "04. 반죽 온도", ["27℃."], total=total, sec=60, calc=[{"type": "dough_temp", "params": {"target": 27}}]),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["198g×12."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 198}}]),
        step(rid, 7, "07. 중간 발효", ["10~20분."], total=total, sec=900, timers=[{"type": "rest", "label": "중간 발효", "durationSec": 1200}]),
        step(rid, 8, "08. 밀어펴기", ["가스 제거."], total=total, sec=180),
        step(rid, 9, "09. 3겹 접기", ["3겹 접기."], total=total, sec=240),
        step(rid, 10, "10. 말기·봉합", ["말기·봉합."], total=total, sec=300),
        step(rid, 11, "11. 패닝", ["3개씩 4팬 패닝 (198g×3=1식빵)."], total=total, sec=360, cl=[("pan_4", "4팬 패닝")]),
        second_ferm_step(rid, 12, total, ["30분 전후, 팬 위 1cm."], sec=1800),
        bake_step(rid, 13, total, 170, 190, 1800, ["170/190℃, 30분."]),
    ]
    return build(
        rid, "쌀식빵", "bread", 13200, "straight",
        {"top": 170, "bottom": 190, "unit": "celsius", "timeSec": 1800},
        std_ferm(s=1800),
        [
            kp("시험 정보", ["3시간 40분", "198g×12", "3개/팬×4"]),
            kp("반죽", ["발전 후기", "27℃"]),
            kp("발효", ["2차: 팬 위 1cm"]),
            kp("굽기", ["170/190℃", "30분"]),
            kp("주요 감점 포인트", ["4팬 균일", "흰 조직"]),
        ],
        [
            ing("강력분", 910, "flour"), ing("쌀가루", 390, "flour"), ing("물", 819, "liquid"),
            ing("이스트", 39, "yeast"), ing("소금", 23.4, "salt"), ing("설탕", 91, "sweetener"),
            ing("쇼트닝", 65, "fat"), ing("탈지분유", 52, "powder"), ing("제빵개량제", 26, "improver"),
        ],
        steps,
        [("white_crumb", "흰색 조직."), ("four_loaves", "4개 식빵 균일."), ("three_peaks", "3봉우리 균일.")],
    )


def chestnut_bread() -> dict:
    rid = "chestnut_bread"
    total = 15
    steps = [
        weigh_step(rid, 10, ["토핑·충전재는 계량 시간 제외."], total=total),
        *mix_steps(rid, "버터", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할", ["450g×5."], total=total, sec=360, calc=[{"type": "division_weight", "params": {"target": 450}}]),
        step(rid, 7, "07. 둥글리기", ["둥글리기."], total=total, sec=300),
        step(rid, 8, "08. 중간 발효", ["10~20분."], total=total, sec=900, timers=[{"type": "rest", "label": "중간 발효", "durationSec": 1200}]),
        step(rid, 9, "09. 밀어펴기", ["가스 제거."], total=total, sec=180, image="step3.jpg"),
        step(rid, 10, "10. 충전", ["통조림밤 80g 충전."], total=total, sec=300, image="step3.jpg"),
        step(rid, 11, "11. 말기·봉합", ["원통 말기·봉합."], total=total, sec=300, image="step4.jpg"),
        step(rid, 12, "12. 2차 발효", ["팬닝, 팬 위 2cm."], total=total, sec=1800, timers=[{"type": "proofing", "label": "2차 발효", "durationSec": 1800}], image="step4.jpg"),
        step(rid, 13, "13. 토핑", ["토핑 제조·바르기, 아몬드 슬라이스."], total=total, sec=360, image="step4.jpg"),
        bake_step(rid, 14, total, 180, 190, 1800, ["180/190℃, 30분."]),
    ]
    return build(
        rid, "밤식빵", "bread", 13200, "straight",
        {"top": 180, "bottom": 190, "unit": "celsius", "timeSec": 1800},
        std_ferm(s=1800),
        [
            kp("시험 정보", ["3시간 40분", "450g+밤80g×5"]),
            kp("반죽", ["스트레이트", "27℃"]),
            kp("토핑", ["토핑+아몬드"]),
            kp("굽기", ["180/190℃"]),
            kp("주요 감점 포인트", ["밤 분포·토핑"]),
        ],
        [
            ing("강력분", 960, "flour"), ing("중력분", 240, "flour"), ing("물", 624, "liquid"),
            ing("이스트", 54, "yeast"), ing("제빵개량제", 12, "improver"), ing("소금", 24, "salt"),
            ing("설탕", 144, "sweetener"), ing("버터", 96, "fat"), ing("탈지분유", 36, "powder"), ing("달걀", 120, "egg"),
            ing("통조림밤", 400, "filling"),
            ing("중력분(토핑)", 100, "flour"), ing("마가린(토핑)", 100, "fat"), ing("설탕(토핑)", 60, "sweetener"),
            ing("베이킹파우더(토핑)", 2, "powder"), ing("달걀(토핑)", 60, "egg"), ing("아몬드슬라이스", 50, "filling"),
        ],
        steps,
        [("topping_cover", "토핑이 반죽을 덮어야 함"), ("chestnut_even", "밤 고르게 분포"), ("uniform_five", "5개 균일")],
    )


def corn_bread() -> dict:
    rid = "corn_bread"
    total = 13
    steps = [
        weigh_step(rid, 10, total=total),
        *mix_steps(rid, "쇼트닝", total),
        first_ferm_step(rid, 5, total),
        step(rid, 6, "06. 분할·둥글리기", ["180g×12."], total=total, sec=600, calc=[{"type": "division_weight", "params": {"target": 180}}]),
        step(rid, 7, "07. 밀어펴기", ["가스 제거."], total=total, sec=180),
        step(rid, 8, "08. 3겹 접기", ["3겹 접기."], total=total, sec=240),
        step(rid, 9, "09. 말기·봉합", ["말기·봉합."], total=total, sec=300),
        step(rid, 10, "10. 패닝", ["3개씩 4팬 (180g×3=1식빵)."], total=total, sec=360, cl=[("pan_4", "4팬 패닝")]),
        second_ferm_step(rid, 11, total, ["30~40분, 팬 위 1cm."], sec=2100),
        bake_step(rid, 12, total, 170, 190, 1800, ["170/190℃, 30분."]),
    ]
    return build(
        rid, "옥수수식빵", "bread", 13200, "straight",
        {"top": 170, "bottom": 190, "unit": "celsius", "timeSec": 1800},
        {"first": {"temperature": 27, "humidity": "75~80%", "timeSec": 2700}, "second": {"temperature": "35~40", "humidity": "85~90%", "timeSec": 2100}},
        [
            kp("시험 정보", ["3시간 40분", "180g×12", "4팬"]),
            kp("반죽", ["옥수수분말 20%", "27℃"]),
            kp("굽기", ["170/190℃"]),
            kp("주요 감점 포인트", ["4팬 균일", "3봉우리"]),
        ],
        [
            ing("강력분", 960, "flour"), ing("옥수수분말", 240, "powder"), ing("물", 720, "liquid"),
            ing("이스트", 36, "yeast"), ing("제빵개량제", 12, "improver"), ing("소금", 24, "salt"),
            ing("설탕", 96, "sweetener"), ing("쇼트닝", 84, "fat"), ing("탈지분유", 36, "powder"), ing("달걀", 60, "egg"),
        ],
        steps,
        [("uniform_four", "4개 식빵 균일"), ("three_peaks", "3봉우리"), ("corn_color", "옥수수색 균일")],
    )


ALL = [
    butter_top, butter_roll, red_bean_bread, pastry_twist, soboro_bread, cream_bread,
    mocha_bread, grissini, whole_wheat_bread, rye_bread, sausage_bread, bagel,
    bread_donut, rice_bread, chestnut_bread, corn_bread,
]


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    for fn in ALL:
        data = fn()
        path = OUT / f"{data['id']}.json"
        path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(path.name)


if __name__ == "__main__":
    main()
