// 레시피 JSON 이 참조하는 이미지가 실제로 존재하는지, 그리고 pubspec 의 asset
// 목록에 해당 폴더가 등록돼 있는지 검사한다.
//
//   dart run tool/verify_assets.dart          // 요약
//   dart run tool/verify_assets.dart -v       // 누락 경로 전부 출력
//
// 누락이 있으면 exit code 1.

import 'dart:convert';
import 'dart:io';

const _recipeDir = 'assets/json/recipes';
const _listPath = 'assets/json/recipe_list.json';
const _pubspecPath = 'pubspec.yaml';

void main(List<String> args) {
  final verbose = args.contains('-v') || args.contains('--verbose');
  final pubspec = File(_pubspecPath).readAsStringSync();

  final files = Directory(_recipeDir)
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  var totalRefs = 0;
  var totalMissing = 0;
  final incomplete = <String>[];

  stdout.writeln('레시피                            단계  이미지  누락');
  for (final file in files) {
    final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final id = data['id'] as String;
    final steps = (data['steps'] as List).cast<Map<String, dynamic>>();

    // imageUrl 이 빈 문자열인 단계는 원본에 쓸 만한 사진이 없어 의도적으로 비워둔
    // 경우다(앱은 플레이스홀더를 표시한다). 누락으로 세지 않는다.
    final blank = steps.where((s) => (s['imageUrl'] as String).isEmpty).length;
    final refs = <String>{
      data['thumbnailUrl'] as String,
      for (final s in steps)
        if ((s['imageUrl'] as String).isNotEmpty) s['imageUrl'] as String,
    };
    final missing = refs.where((r) => !File(r).existsSync()).toList()..sort();

    totalRefs += refs.length;
    totalMissing += missing.length;
    if (missing.isNotEmpty) incomplete.add(id);

    final mark = missing.isEmpty ? (blank == 0 ? 'OK' : 'OK(-$blank)') : '${missing.length}';
    stdout.writeln('${id.padRight(32)}${steps.length.toString().padLeft(4)}'
        '${refs.length.toString().padLeft(8)}${mark.padLeft(8)}');
    if (verbose && missing.isNotEmpty) {
      for (final m in missing) {
        stdout.writeln('    - $m');
      }
    }

    if (!pubspec.contains('assets/images/recipes/$id/')) {
      stderr.writeln('[$id] pubspec.yaml 의 assets 목록에 폴더가 없습니다.');
    }
  }

  // recipe_list.json 썸네일도 함께 확인한다.
  final list = jsonDecode(File(_listPath).readAsStringSync());
  final listItems = (list is List ? list : (list as Map)['items'] as List)
      .cast<Map<String, dynamic>>();
  final listMissing = listItems
      .map((e) => e['thumbnailUrl'] as String?)
      .whereType<String>()
      .where((r) => !File(r).existsSync())
      .toList();

  stdout.writeln('\n이미지 참조 $totalRefs건 중 누락 $totalMissing건'
      ' / 미완성 레시피 ${incomplete.length}개'
      '${listMissing.isEmpty ? '' : ' / 목록 썸네일 누락 ${listMissing.length}건'}');
  if (incomplete.isNotEmpty) {
    stdout.writeln('미완성: ${incomplete.join(', ')}');
  }

  exit(totalMissing + listMissing.length == 0 ? 0 : 1);
}
