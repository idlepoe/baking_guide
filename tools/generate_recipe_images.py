#!/usr/bin/env python3
"""
스위트롤(및 확장 가능) 레시피 JSON의 thumbnailUrl, keyPoints imageUrl, steps imageUrl에
맞는 이미지를 Vertex AI Express + Imagen 4로 생성하고 JSON 경로를 갱신합니다.

생성 정책 (모든 job 공통):
  - 제빵기능사 학습 교재에 실리는 사진 스타일
  - 반드시 제빵(빵·반죽·오븐·베이커리) 장면만
  - 텍스트·숫자·라벨·로고 등 어떤 글자도 없음
  - keypoint도 동일 정책 + 제빵 요약 장면 (KEYPOINT_PREFIX)

실행 조건:
  - 레시피 JSON의 thumbnailUrl / imageUrl 이 비어 있을 때만 생성·갱신
  - (필드 없음, null, 빈 문자열, 공백만 있음)

사용 예:
  pip install -r tools/requirements-image-gen.txt
  copy tools\\image_gen.secrets.example.json tools\\image_gen.secrets.json
  # secrets 파일에 api_key 입력 후:
  python tools/generate_recipe_images.py --recipe sweet_roll

환경 변수 (secrets 파일보다 우선하지 않음 — 파일이 없을 때만 사용):
  GOOGLE_API_KEY, VERTEX_API_KEY, IMAGEN_API_KEY
"""

from __future__ import annotations

# 제빵 기능사 공통 핵심 정보(keyPoints) 이미지 — 레시피별이 아님
KEYPOINTS_IMAGE_BASE = "assets/images/keypoints"

import argparse
import json
import logging
import os
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any

from google import genai
from google.genai import types

ROOT = Path(__file__).resolve().parents[1]
RECIPE_JSON_DIR = ROOT / "assets" / "json" / "recipes"
RECIPE_LIST_JSON = ROOT / "assets" / "json" / "recipe_list.json"
SECRETS_PATH = Path(__file__).resolve().parent / "image_gen.secrets.json"
SECRETS_EXAMPLE = Path(__file__).resolve().parent / "image_gen.secrets.example.json"

# 제빵기능사 학습 교재에 실리는 사진 스타일 (모든 job 공통)
TEXTBOOK_STYLE = (
    "Photograph exactly like an image printed in a Korean baking technician "
    "(제빵기능사) vocational study textbook for bread production: single clear "
    "instructional photo, neutral background, realistic commercial bakery, "
    "educational step-by-step quality, not a poster or advertisement."
)

# 글자·숫자·라벨 등 어떤 텍스트도 금지
NO_TEXT_RULE = (
    "ABSOLUTELY NO TEXT: no letters, numbers, captions, titles, subtitles, "
    "labels, signs, logos, watermarks, UI, timers on screen, recipe cards, "
    "Korean or English characters, speech bubbles, diagrams with writing."
)

# 반드시 제빵(빵·반죽) 관련만
BAKING_ONLY_RULE = (
    "STRICT BAKING ONLY: bread and yeast dough work only — flour, yeast, "
    "salt, sugar, butter, dough mixer, proofing cabinet, bench, rolling pin, "
    "baking sheet, deck oven, loaf pan, pastry brush, bench scraper. "
    "Sweet roll / cinnamon roll bread exam product only for this recipe. "
    "Forbidden: sushi, pizza, ramen, steak, salad, soup, non-bread desserts, "
    "cake fondant decoration, chocolate confectionery display, café latte art."
)

STYLE_PREFIX = (
    f"{TEXTBOOK_STYLE} {NO_TEXT_RULE} {BAKING_ONLY_RULE} "
    "Baker hands only, no visible face."
)

# keyPoints 요약 카드용 — 교재 핵심 포인트 삽화이되 반드시 제빵 장면
KEYPOINT_PREFIX = (
    f"{TEXTBOOK_STYLE} {NO_TEXT_RULE} {BAKING_ONLY_RULE} "
    "Textbook keypoint summary illustration for bread baking exam prep, "
    "one iconic baking scene (not an icon chart), photorealistic."
)

NEGATIVE_PROMPT = (
    "text, letters, numbers, caption, title, subtitle, label, sign, logo, watermark, "
    "UI overlay, recipe card, diagram with words, Korean text, English text, "
    "non-baking food, sushi, pizza, ramen, steak, salad, soup, candy store, "
    "wedding cake topper, cartoon, anime, infographic, warning sign with text, "
    "outdoor unrelated scene, supermarket snack aisle"
)

MODEL_DEFAULT = "imagen-4.0-generate-001"
ASPECT_RATIO = "16:9"
MIME_TYPE = "image/png"
REQUEST_DELAY_SEC = 2.0

logger = logging.getLogger("recipe_image_gen")


@dataclass(frozen=True)
class ImageJob:
    """단일 이미지 생성 작업."""

    job_id: str
    rel_path: str
    prompt: str
    json_pointer: str  # human-readable: thumbnail | keypoint:exam | step:3


def _step_prompt(scene: str) -> str:
    """공정 단계(step)용 교재 사진 프롬프트."""
    return f"{STYLE_PREFIX} Textbook process step photo: {scene}"


def _keypoint_prompt(scene: str) -> str:
    """요약 keypoint용 — 반드시 제빵 교재 이미지."""
    return f"{KEYPOINT_PREFIX} Keypoint baking scene: {scene}"


def _thumbnail_prompt(scene: str) -> str:
    return f"{STYLE_PREFIX} Textbook cover-style finished product photo: {scene}"


def _load_secrets() -> dict[str, str]:
    data: dict[str, str] = {}
    if SECRETS_PATH.is_file():
        with SECRETS_PATH.open(encoding="utf-8") as f:
            raw = json.load(f)
        for k in ("api_key", "project_id", "location", "model"):
            if raw.get(k):
                data[k] = str(raw[k])
    for env_name in ("GOOGLE_API_KEY", "VERTEX_API_KEY", "IMAGEN_API_KEY"):
        if not data.get("api_key") and os.environ.get(env_name):
            data["api_key"] = os.environ[env_name]
    if not data.get("api_key"):
        print(
            "API 키가 없습니다. tools/image_gen.secrets.json 을 만들거나 "
            "GOOGLE_API_KEY 환경 변수를 설정하세요.",
            file=sys.stderr,
        )
        print(f"예시: copy {SECRETS_EXAMPLE.name} → {SECRETS_PATH.name}", file=sys.stderr)
        sys.exit(1)
    data.setdefault("project_id", "bbangsilgi")
    data.setdefault("location", "us-central1")
    data.setdefault("model", MODEL_DEFAULT)
    return data


def _sweet_roll_jobs(recipe_id: str) -> list[ImageJob]:
    base = f"assets/images/recipes/{recipe_id}"
    return [
        ImageJob(
            "thumbnail",
            f"{base}/main.png",
            _thumbnail_prompt(
                "finished sweet rolls on baking sheets — palm-leaf and triple-leaf "
                "cinnamon bread rolls, golden brown, uniform size, 제빵기능사 exam presentation"
            ),
            "thumbnail",
        ),
        ImageJob(
            "keypoint_exam",
            f"{KEYPOINTS_IMAGE_BASE}/exam.png",
            _keypoint_prompt(
                "weighing bread ingredients for sweet roll dough — flour, sugar, yeast, "
                "eggs, butter in bowls on stainless tray, 제빵 시험 재료 계량 장면"
            ),
            "keypoint:시험 정보",
        ),
        ImageJob(
            "keypoint_mixer",
            f"{KEYPOINTS_IMAGE_BASE}/mixer.png",
            _keypoint_prompt(
                "spiral dough mixer kneading bread dough, straight dough method, "
                "제빵기능사 반죽(믹싱) 교재 사진"
            ),
            "keypoint:반죽",
        ),
        ImageJob(
            "keypoint_fermentation",
            f"{KEYPOINTS_IMAGE_BASE}/fermentation.png",
            _keypoint_prompt(
                "bulk bread dough first fermentation in proofer, finger poke test, "
                "제빵 1차 발효 교재 사진"
            ),
            "keypoint:발효",
        ),
        ImageJob(
            "keypoint_shaping",
            f"{KEYPOINTS_IMAGE_BASE}/shaping.png",
            _keypoint_prompt(
                "shaping sweet rolls — cinnamon dough log, palm-leaf and triple-leaf cuts "
                "on bakery bench, 제빵 성형 교재 사진"
            ),
            "keypoint:성형",
        ),
        ImageJob(
            "keypoint_oven",
            f"{KEYPOINTS_IMAGE_BASE}/oven.png",
            _keypoint_prompt(
                "deck oven baking tray of cinnamon sweet rolls, golden bread color, "
                "제빵 굽기(오븐) 교재 사진"
            ),
            "keypoint:굽기",
        ),
        ImageJob(
            "keypoint_warning",
            f"{KEYPOINTS_IMAGE_BASE}/warning.png",
            _keypoint_prompt(
                "bread baking quality issues only — torn seam on cinnamon roll, uneven "
                "cinnamon stripes, over-proofed misshapen rolls on sheet, no warning text signs, "
                "제빵 감점 포인트 교재용 비교 사진"
            ),
            "keypoint:주요 감점 포인트",
        ),
        ImageJob(
            "step01",
            f"{base}/step01.png",
            _step_prompt(
                "weighing bread ingredients in bowls on tray for sweet roll dough"
            ),
            "step:01 재료 계량",
        ),
        ImageJob(
            "step02",
            f"{base}/step02.png",
            _step_prompt(
                "stand mixer kneading bread dough, ingredients except shortening"
            ),
            "step:02 초기 믹싱",
        ),
        ImageJob(
            "step03",
            f"{base}/step03.png",
            _step_prompt(
                "windowpane gluten test on bread dough, cleanup stage shortening in mixer"
            ),
            "step:03 클린업·최종 믹싱",
        ),
        ImageJob(
            "step04",
            f"{base}/step04.png",
            _step_prompt(
                "thermometer in bread dough at 27C, bulk dough first proofing in proofer"
            ),
            "step:04 반죽 온도·1차 발효",
        ),
        ImageJob(
            "step05",
            f"{base}/step05.png",
            _step_prompt(
                "dividing bread dough, rolling two sheets flat with rolling pin on bench"
            ),
            "step:05 분할·밀어펴기",
        ),
        ImageJob(
            "step06",
            f"{base}/step06.png",
            _step_prompt(
                "brushing melted butter on rolled bread dough sheet, bare edge border"
            ),
            "step:06 버터 도포",
        ),
        ImageJob(
            "step07",
            f"{base}/step07.png",
            _step_prompt(
                "sprinkling cinnamon sugar on buttered bread dough sheet, stripe pattern"
            ),
            "step:07 계피설탕",
        ),
        ImageJob(
            "step08",
            f"{base}/step08.png",
            _step_prompt(
                "rolling bread dough sheet into tight cinnamon roll cylinder log"
            ),
            "step:08 원통 말기",
        ),
        ImageJob(
            "step09",
            f"{base}/step09.png",
            _step_prompt(
                "sealing cinnamon roll dough log seam, pinching bread dough closed"
            ),
            "step:09 이음매 봉합",
        ),
        ImageJob(
            "step10",
            f"{base}/step10.png",
            _step_prompt(
                "cutting cinnamon roll log into palm-leaf shapes, center slit in bread dough pieces"
            ),
            "step:10 야자잎 재단",
        ),
        ImageJob(
            "step11",
            f"{base}/step11.png",
            _step_prompt(
                "palm-leaf cinnamon bread rolls on baking sheet with spacing before proofing"
            ),
            "step:11 야자잎 패닝",
        ),
        ImageJob(
            "step12",
            f"{base}/step12.png",
            _step_prompt(
                "cutting cinnamon roll log for triple-leaf bread shapes, two slits in dough"
            ),
            "step:12 트리플리프 재단",
        ),
        ImageJob(
            "step13",
            f"{base}/step13.png",
            _step_prompt(
                "triple-leaf cinnamon rolls on sheet in bread proofer, second fermentation"
            ),
            "step:13 트리플리프 패닝·2차 발효",
        ),
        ImageJob(
            "step14",
            f"{base}/step14.png",
            _step_prompt(
                "baked golden palm-leaf and triple-leaf cinnamon sweet bread rolls from oven"
            ),
            "step:14 굽기",
        ),
    ]


RECIPE_JOB_BUILDERS: dict[str, Any] = {
    "sweet_roll": _sweet_roll_jobs,
}

KEYPOINT_SLUGS = {
    "시험 정보": "exam",
    "반죽": "mixer",
    "발효": "fermentation",
    "성형": "shaping",
    "굽기": "oven",
    "주요 감점 포인트": "warning",
}


def _is_url_empty(value: object) -> bool:
    if value is None:
        return True
    if not isinstance(value, str):
        return True
    return not value.strip()


def _get_url_for_job(job: ImageJob, data: dict[str, Any]) -> object:
    if job.job_id == "thumbnail":
        return data.get("thumbnailUrl")
    if job.job_id.startswith("keypoint_"):
        slug = job.job_id.removeprefix("keypoint_")
        for group in data.get("summary", {}).get("keyPoints", []):
            if KEYPOINT_SLUGS.get(group.get("title", "")) == slug:
                return group.get("imageUrl")
        return None
    if job.job_id.startswith("step"):
        step_no = int(job.job_id.removeprefix("step"))
        for step in data.get("steps", []):
            if step.get("stepNo") == step_no:
                return step.get("imageUrl")
        return None
    return None


def _job_needs_image(job: ImageJob, data: dict[str, Any]) -> bool:
    return _is_url_empty(_get_url_for_job(job, data))


def _load_recipe_data(recipe_path: Path) -> dict[str, Any]:
    with recipe_path.open(encoding="utf-8") as f:
        return json.load(f)


def _format_url_for_log(value: object) -> str:
    if value is None:
        return "(없음)"
    if isinstance(value, str) and not value.strip():
        return "(비어 있음)"
    return str(value)


def _setup_logging(verbose: bool, log_file: str | None) -> None:
    level = logging.DEBUG if verbose else logging.INFO
    handlers: list[logging.Handler] = [logging.StreamHandler(sys.stdout)]
    if log_file:
        handlers.append(
            logging.FileHandler(log_file, encoding="utf-8", mode="a")
        )
    logging.basicConfig(
        level=level,
        format="%(asctime)s [%(levelname)s] %(message)s",
        datefmt="%H:%M:%S",
        handlers=handlers,
        force=True,
    )
    if hasattr(sys.stdout, "reconfigure"):
        try:
            sys.stdout.reconfigure(encoding="utf-8")
        except Exception:  # noqa: BLE001
            pass


def _log_job_detail(
    job: ImageJob,
    out_path: Path,
    recipe_data: dict[str, Any],
    *,
    model: str,
    dry_run: bool,
    skip_reason: str | None = None,
) -> None:
    logger.info("——— 이미지 작업 ———")
    logger.info("  job_id      : %s", job.job_id)
    logger.info("  대상        : %s", job.json_pointer)
    logger.info("  저장 경로   : %s", out_path.relative_to(ROOT))
    logger.info("  모델        : %s", model)
    logger.info("  교재 스타일 : 제빵기능사 학습 교재 삽화")
    logger.info("  제빵 전용   : 예 (BAKING_ONLY_RULE)")
    logger.info("  텍스트 금지 : 예 (NO_TEXT_RULE)")
    if job.job_id.startswith("keypoint_"):
        logger.info("  유형        : keypoint (제빵 요약 장면)")
    logger.info("  프롬프트    :\n%s", job.prompt)
    logger.info("  네거티브    :\n%s", NEGATIVE_PROMPT)
    current = _format_url_for_log(_get_url_for_job(job, recipe_data))
    logger.info("  JSON URL    : %s", current)
    if skip_reason:
        logger.info("  상태        : 건너뜀 (%s)", skip_reason)
    elif dry_run:
        logger.info("  상태        : dry-run (API 호출 없음)")
    else:
        logger.info("  상태        : API 호출 예정")


def _create_client(secrets: dict[str, str]) -> genai.Client:
    logger.info(
        "Vertex Express 클라이언트 초기화 (model=%s)", secrets.get("model")
    )
    return genai.Client(vertexai=True, api_key=secrets["api_key"])


def _generate_one(
    client: genai.Client,
    model: str,
    job: ImageJob,
    out_path: Path,
    recipe_data: dict[str, Any],
    dry_run: bool,
) -> None:
    _log_job_detail(job, out_path, recipe_data, model=model, dry_run=dry_run)
    if dry_run:
        return

    out_path.parent.mkdir(parents=True, exist_ok=True)
    started = time.perf_counter()
    logger.info("Imagen API 호출 시작…")

    response = client.models.generate_images(
        model=model,
        prompt=job.prompt,
        config=types.GenerateImagesConfig(
            number_of_images=1,
            output_mime_type=MIME_TYPE,
            aspect_ratio=ASPECT_RATIO,
            include_rai_reason=True,
            person_generation="allow_adult",
            negative_prompt=NEGATIVE_PROMPT,
            enhance_prompt=False,
        ),
    )
    elapsed = time.perf_counter() - started

    if not response.generated_images:
        logger.error("응답에 generated_images 없음 (%.1f초)", elapsed)
        raise RuntimeError(f"이미지 없음: {job.job_id} ({job.json_pointer})")

    generated = response.generated_images[0]
    if generated.rai_filtered_reason:
        logger.error("RAI 필터: %s", generated.rai_filtered_reason)
        raise RuntimeError(
            f"RAI 필터됨 [{job.job_id}]: {generated.rai_filtered_reason}"
        )

    generated.image.save(str(out_path))
    size_kb = out_path.stat().st_size / 1024
    logger.info(
        "저장 완료: %s (%.1f KB, %.1f초)",
        out_path.relative_to(ROOT),
        size_kb,
        elapsed,
    )


def _patch_recipe_json(
    recipe_path: Path,
    recipe_id: str,
    dry_run: bool,
    succeeded_job_ids: set[str],
) -> None:
    if not succeeded_job_ids:
        return

    with recipe_path.open(encoding="utf-8") as f:
        data = json.load(f)

    base = f"assets/images/recipes/{recipe_id}"
    if "thumbnail" in succeeded_job_ids:
        data["thumbnailUrl"] = f"{base}/main.png"

    for group in data.get("summary", {}).get("keyPoints", []):
        title = group.get("title", "")
        slug = KEYPOINT_SLUGS.get(title)
        if slug and f"keypoint_{slug}" in succeeded_job_ids:
            group["imageUrl"] = f"{KEYPOINTS_IMAGE_BASE}/{slug}.png"

    for step in data.get("steps", []):
        step_no = step.get("stepNo")
        if isinstance(step_no, int) and f"step{step_no:02d}" in succeeded_job_ids:
            step["imageUrl"] = f"{base}/step{step_no:02d}.png"

    if dry_run:
        logger.info(
            "[dry-run] JSON 갱신 예정: %s (%d건)",
            recipe_path.name,
            len(succeeded_job_ids),
        )
        return

    with recipe_path.open("w", encoding="utf-8", newline="\n") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")
    logger.info(
        "JSON 갱신: %s (%d건 URL 반영)",
        recipe_path.relative_to(ROOT),
        len(succeeded_job_ids),
    )


def _patch_recipe_list(
    recipe_id: str,
    thumbnail_url: str,
    dry_run: bool,
    *,
    patch_thumbnail: bool,
) -> None:
    if not patch_thumbnail or not RECIPE_LIST_JSON.is_file():
        return
    with RECIPE_LIST_JSON.open(encoding="utf-8") as f:
        items = json.load(f)
    for item in items:
        if item.get("id") != recipe_id:
            continue
        if not _is_url_empty(item.get("thumbnailUrl")):
            logger.info(
                "recipe_list.json 썸네일 URL 있음 — 갱신 생략"
            )
            return
        item["thumbnailUrl"] = thumbnail_url
        break
    if dry_run:
        logger.info("[dry-run] recipe_list.json thumbnail 갱신 예정")
        return
    with RECIPE_LIST_JSON.open("w", encoding="utf-8", newline="\n") as f:
        json.dump(items, f, ensure_ascii=False, indent=2)
        f.write("\n")
    logger.info("JSON 갱신: %s", RECIPE_LIST_JSON.relative_to(ROOT))


def main() -> None:
    parser = argparse.ArgumentParser(description="Imagen 4 레시피 이미지 생성")
    parser.add_argument(
        "--recipe",
        default="sweet_roll",
        choices=sorted(RECIPE_JOB_BUILDERS.keys()),
        help="레시피 ID",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="프롬프트·경로만 출력, API 호출·파일 쓰기 없음",
    )
    parser.add_argument(
        "--only",
        choices=("thumbnail", "keypoints", "steps", "all"),
        default="all",
        help="생성 대상 필터",
    )
    parser.add_argument(
        "--delay",
        type=float,
        default=REQUEST_DELAY_SEC,
        help="요청 간 대기(초)",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="DEBUG 로그 출력",
    )
    parser.add_argument(
        "--log-file",
        default="",
        help="로그 파일 경로 (예: tools/image_gen.log)",
    )
    args = parser.parse_args()

    _setup_logging(args.verbose, args.log_file or None)
    secrets = _load_secrets()
    recipe_path = RECIPE_JSON_DIR / f"{args.recipe}.json"
    if not recipe_path.is_file():
        print(f"레시피 없음: {recipe_path}", file=sys.stderr)
        sys.exit(1)

    recipe_data = _load_recipe_data(recipe_path)
    all_jobs = RECIPE_JOB_BUILDERS[args.recipe](args.recipe)
    if args.only == "thumbnail":
        all_jobs = [j for j in all_jobs if j.job_id == "thumbnail"]
    elif args.only == "keypoints":
        all_jobs = [j for j in all_jobs if j.job_id.startswith("keypoint_")]
    elif args.only == "steps":
        all_jobs = [j for j in all_jobs if j.job_id.startswith("step")]

    pending_jobs = [j for j in all_jobs if _job_needs_image(j, recipe_data)]
    skipped_filled = len(all_jobs) - len(pending_jobs)

    logger.info(
        "레시피: %s | 전체 %d건 | URL 비어 있음 %d건 | 이미 설정됨 %d건 | only=%s",
        args.recipe,
        len(all_jobs),
        len(pending_jobs),
        skipped_filled,
        args.only,
    )
    logger.info(
        "정책: 제빵기능사 학습 교재 사진 | 제빵만 | 텍스트·숫자·라벨 금지"
    )
    logger.info("실행 조건: thumbnailUrl / imageUrl 이 비어 있을 때만 생성")

    pending_set = set(pending_jobs)
    for job in all_jobs:
        if job not in pending_set:
            _log_job_detail(
                job,
                ROOT / job.rel_path,
                recipe_data,
                model=secrets["model"],
                dry_run=args.dry_run,
                skip_reason="JSON에 thumbnailUrl/imageUrl 이미 있음",
            )

    if not pending_jobs:
        logger.info("생성할 항목이 없습니다. 종료합니다.")
        return

    client = None if args.dry_run else _create_client(secrets)
    model = secrets["model"]

    failed: list[str] = []
    succeeded_job_ids: set[str] = set()
    for i, job in enumerate(pending_jobs):
        out_path = ROOT / job.rel_path
        logger.info("[%d/%d] 다음 작업", i + 1, len(pending_jobs))
        try:
            _generate_one(client, model, job, out_path, recipe_data, args.dry_run)
            succeeded_job_ids.add(job.job_id)
        except Exception as exc:  # noqa: BLE001 — CLI: collect and report all failures
            failed.append(f"{job.job_id}: {exc}")
            logger.exception("생성 실패 [%s]: %s", job.job_id, exc)
        if not args.dry_run and i < len(pending_jobs) - 1:
            logger.debug("다음 요청 전 %.1f초 대기", args.delay)
            time.sleep(args.delay)

    logger.info(
        "요약: 성공 %d | URL 있어 생략 %d | 실패 %d",
        len(succeeded_job_ids),
        skipped_filled,
        len(failed),
    )

    if succeeded_job_ids or args.dry_run:
        base = f"assets/images/recipes/{args.recipe}"
        ids_for_patch = succeeded_job_ids if not args.dry_run else {
            j.job_id for j in pending_jobs
        }
        _patch_recipe_json(
            recipe_path, args.recipe, args.dry_run, ids_for_patch
        )
        _patch_recipe_list(
            args.recipe,
            f"{base}/main.png",
            args.dry_run,
            patch_thumbnail="thumbnail" in ids_for_patch,
        )
    elif not args.dry_run:
        logger.warning("생성된 이미지가 없어 JSON은 변경하지 않았습니다.")

    if failed:
        logger.error("%d건 실패", len(failed))
        sys.exit(1)

    logger.info("완료.")


if __name__ == "__main__":
    main()
