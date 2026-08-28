// 교재 원본 사진(assets/raw_images/<한글명>/*.jpg)을 크롭하여
// assets/images/recipes/<id>/<stepNo>.png 를 생성한다.
//
//   dart run tool/crop.dart <recipeId> [<recipeId> ...]
//   dart run tool/crop.dart --all
//   dart run tool/crop.dart --preview <recipeId>   // 격자 오버레이만 출력(build/crop_preview)
//
// 교재는 한 페이지가 2열 × 4행 = 8칸 고정 배치이므로, 칸 좌표는 tool/crop_spec.json 의
// "grids" 에 0~1 정규화 좌표로 한 번만 정의하고 레시피별로 참조한다.
// 원본은 EXIF 방향 정보를 가지고 있어 decodeImage 단계에서 이미 정방향으로 펴진다.
// 방향이 어긋나는 폴더만 페이지에 "rotate" 를 지정한다.

import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart' as img;

const _specPath = 'tool/crop_spec.json';
const _rawRoot = 'assets/raw_images';
const _outRoot = 'assets/images/recipes';
const _previewRoot = 'build/crop_preview';

late Map<String, dynamic> _grids;

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: dart run tool/crop.dart [--all|--preview] <recipeId>...');
    exit(64);
  }

  final spec = jsonDecode(File(_specPath).readAsStringSync()) as Map<String, dynamic>;
  _grids = (spec['grids'] as Map).cast<String, dynamic>();
  final recipes = (spec['recipes'] as Map).cast<String, dynamic>();

  final preview = args.contains('--preview');
  final ids = args.contains('--all')
      ? (recipes.keys.toList()..sort())
      : args.where((a) => !a.startsWith('--')).toList();

  if (ids.isEmpty) {
    stderr.writeln('대상 레시피가 없습니다.');
    exit(64);
  }

  var failed = false;
  for (final id in ids) {
    final entry = recipes[id] as Map<String, dynamic>?;
    if (entry == null) {
      stderr.writeln('[$id] crop_spec.json 에 항목이 없습니다.');
      failed = true;
      continue;
    }
    try {
      _processRecipe(id, entry, preview: preview);
    } catch (e) {
      stderr.writeln('[$id] 실패: $e');
      failed = true;
    }
  }
  exit(failed ? 1 : 0);
}

void _processRecipe(String id, Map<String, dynamic> entry, {required bool preview}) {
  final rawDir = entry['rawDir'] as String;
  final pages = (entry['pages'] as List).cast<Map<String, dynamic>>();

  final outDir = Directory(preview ? '$_previewRoot/$id' : '$_outRoot/$id');
  outDir.createSync(recursive: true);

  final steps = <int>{};
  for (final page in pages) {
    final src = File('$_rawRoot/$rawDir/${page['src']}');
    if (!src.existsSync()) throw StateError('원본 없음: ${src.path}');
    final decoded = img.decodeImage(src.readAsBytesSync());
    if (decoded == null) throw StateError('디코드 실패: ${src.path}');

    final rotate = (page['rotate'] as num?)?.toInt() ?? 0;
    final base = rotate == 0 ? decoded : img.copyRotate(decoded, angle: rotate);
    final cells = _cellsOf(page);

    if (preview) {
      final overlay = img.Image.from(base);
      for (final cell in cells) {
        final r = _rectOf(base, cell.rect);
        img.drawRect(overlay,
            x1: r.x, y1: r.y, x2: r.x + r.w, y2: r.y + r.h,
            color: img.ColorRgb8(255, 0, 0), thickness: 8);
      }
      final name = (page['src'] as String).replaceAll(RegExp(r'\.\w+$'), '');
      File('${outDir.path}/$name.png')
          .writeAsBytesSync(img.encodePng(img.copyResize(overlay, width: 1400)));
      continue;
    }

    for (final cell in cells) {
      if (!steps.add(cell.step)) {
        throw StateError('단계 ${cell.step} 이 중복 지정되었습니다.');
      }
      final r = _rectOf(base, cell.rect);
      final cropped = img.copyCrop(base, x: r.x, y: r.y, width: r.w, height: r.h);
      final resized =
          cropped.width > 1200 ? img.copyResize(cropped, width: 1200) : cropped;
      File('${outDir.path}/${cell.step}.png').writeAsBytesSync(img.encodePng(resized));
    }
  }

  if (preview) {
    stdout.writeln('[$id] preview ${pages.length}장 → ${outDir.path}');
    return;
  }
  final sorted = steps.toList()..sort();
  stdout.writeln('[$id] ${sorted.length}단계 크롭 (1~${sorted.last}) → ${outDir.path}');
}

class _Cell {
  const _Cell(this.step, this.rect);
  final int step;
  final List<double> rect;
}

/// 페이지의 칸 목록을 만든다.
/// - `cells`: [{step, rect}] 로 직접 지정 (격자에서 벗어난 예외 페이지용)
/// - `grid` + `startStep` + `count`: 격자 프리셋에서 열 우선으로 채움
List<_Cell> _cellsOf(Map<String, dynamic> page) {
  final explicit = page['cells'] as List?;
  if (explicit != null) {
    return explicit.cast<Map<String, dynamic>>().map((c) {
      final rect = (c['rect'] as List).map((v) => (v as num).toDouble()).toList();
      return _Cell((c['step'] as num).toInt(), rect);
    }).toList();
  }

  final grid = _grids[page['grid'] as String] as Map<String, dynamic>?;
  if (grid == null) throw StateError('알 수 없는 grid: ${page['grid']}');
  final columns = (grid['columns'] as List).cast<Map<String, dynamic>>();

  // 교재는 열 우선(왼쪽 열 위→아래, 그다음 오른쪽 열)으로 칸 번호가 매겨진다.
  final slots = <List<double>>[];
  for (final column in columns) {
    final x = (column['x'] as num).toDouble();
    final w = (column['w'] as num).toDouble();
    for (final row in (column['rows'] as List).cast<List>()) {
      slots.add([x, (row[0] as num).toDouble(), w, (row[1] as num).toDouble()]);
    }
  }

  // `map`: [{step: JSON stepNo, cell: 교재 칸 번호(1-based)}]
  // 교재 단계와 JSON 단계가 1:1이 아닌 품목(대부분의 빵류)에서 사용한다.
  // 여러 JSON 단계가 같은 교재 칸을 참조해도 된다.
  final map = page['map'] as List?;
  if (map != null) {
    return map.cast<Map<String, dynamic>>().map((m) {
      final cell = (m['cell'] as num).toInt();
      if (cell < 1 || cell > slots.length) {
        throw StateError('칸 번호 $cell 이 격자 범위(1~${slots.length})를 벗어납니다.');
      }
      return _Cell((m['step'] as num).toInt(), slots[cell - 1]);
    }).toList();
  }

  // 매핑이 없으면 startStep 부터 순서대로 채운다.
  final startStep = (page['startStep'] as num).toInt();
  final count = (page['count'] as num).toInt();
  if (count > slots.length) {
    throw StateError('격자 칸(${slots.length})보다 count($count)가 큽니다.');
  }
  return [
    for (var i = 0; i < count; i++) _Cell(startStep + i, slots[i]),
  ];
}

class _Rect {
  const _Rect(this.x, this.y, this.w, this.h);
  final int x, y, w, h;
}

_Rect _rectOf(img.Image image, List<double> rect) {
  final x = (rect[0] * image.width).round().clamp(0, image.width - 1);
  final y = (rect[1] * image.height).round().clamp(0, image.height - 1);
  final w = (rect[2] * image.width).round().clamp(1, image.width - x);
  final h = (rect[3] * image.height).round().clamp(1, image.height - y);
  return _Rect(x, y, w, h);
}
