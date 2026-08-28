// 레시피 JSON 의 이미지 경로를 milk_bread 규칙으로 통일한다.
//
//   thumbnailUrl        → assets/images/recipes/<id>/main.png
//   steps[].imageUrl    → assets/images/recipes/<id>/<stepNo>.png
//
// 기존 JSON 은 step1.jpg / main.jpg 처럼 규칙이 제각각이고 확장자도 실제 파일과
// 어긋나 있어(대부분 .png) 전부 깨진 참조였다.
//
//   dart run tool/normalize_image_refs.dart [--dry-run]

import 'dart:convert';
import 'dart:io';

const _recipeDir = 'assets/json/recipes';

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  final files = Directory(_recipeDir)
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  var changedFiles = 0;
  var changedRefs = 0;

  for (final file in files) {
    final raw = file.readAsStringSync();
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final id = data['id'] as String;
    var changed = 0;

    final thumb = 'assets/images/recipes/$id/main.png';
    if (data['thumbnailUrl'] != thumb) {
      data['thumbnailUrl'] = thumb;
      changed++;
    }

    for (final step in (data['steps'] as List).cast<Map<String, dynamic>>()) {
      final stepNo = (step['stepNo'] as num).toInt();
      final url = 'assets/images/recipes/$id/$stepNo.png';
      if (step['imageUrl'] != url) {
        step['imageUrl'] = url;
        changed++;
      }
    }

    if (changed == 0) continue;
    changedFiles++;
    changedRefs += changed;
    if (!dryRun) {
      file.writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(data)}\n');
    }
    stdout.writeln('[$id] $changed건');
  }

  stdout.writeln(dryRun
      ? '\n(dry-run) $changedFiles개 파일 / $changedRefs건 변경 예정'
      : '\n$changedFiles개 파일 / $changedRefs건 변경 완료');
}
