// 레시피 JSON 에 쓰인 열거형 문자열이 실제 Dart enum 의 @JsonValue 와 일치하는지
// 검사한다. 오타(예: 'resting' vs 'rest')는 런타임 파싱 예외로만 드러나므로
// 여기서 미리 잡는다.
//
//   dart run tool/verify_enums.dart
//
// 불일치가 있으면 exit code 1.

import 'dart:convert';
import 'dart:io';

const _recipeDir = 'assets/json/recipes';
const _enumDir = 'lib/app/data/models/enums';

/// JSON 상의 위치(경로) → 값을 검사할 enum 파일
const _checks = <String, String>{
  'steps[].timers[].type': 'timer_kind.dart',
  'steps[].calculators[].type': 'calculator_kind.dart',
  'steps[].deductionPoints[].severity': 'deduction_severity.dart',
  'summary.mixingMethod': 'mixing_method.dart',
  'ingredients[].category': 'ingredient_category.dart',
};

Set<String> _allowedValues(String enumFile) {
  final source = File('$_enumDir/$enumFile').readAsStringSync();
  return RegExp(r"@JsonValue\('([^']*)'\)")
      .allMatches(source)
      .map((m) => m.group(1)!)
      .toSet();
}

void main() {
  final allowed = <String, Set<String>>{
    for (final entry in _checks.entries) entry.key: _allowedValues(entry.value),
  };

  final problems = <String>[];
  final files = Directory(_recipeDir)
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (final file in files) {
    final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final id = data['id'] as String;

    void check(String path, Object? value) {
      if (value is! String) return;
      final valid = allowed[path]!;
      if (!valid.contains(value)) {
        problems.add("[$id] $path = '$value' "
            '(허용: ${(valid.toList()..sort()).join(", ")})');
      }
    }

    check('summary.mixingMethod', (data['summary'] as Map)['mixingMethod']);
    for (final i in (data['ingredients'] as List).cast<Map<String, dynamic>>()) {
      check('ingredients[].category', i['category']);
    }
    for (final s in (data['steps'] as List).cast<Map<String, dynamic>>()) {
      for (final t in (s['timers'] as List).cast<Map<String, dynamic>>()) {
        check('steps[].timers[].type', t['type']);
      }
      for (final c in (s['calculators'] as List).cast<Map<String, dynamic>>()) {
        check('steps[].calculators[].type', c['type']);
      }
      for (final p
          in (s['deductionPoints'] as List).cast<Map<String, dynamic>>()) {
        check('steps[].deductionPoints[].severity', p['severity']);
      }
    }
  }

  if (problems.isEmpty) {
    stdout.writeln('열거형 값 ${files.length}개 파일 검사 통과');
    return;
  }
  for (final p in problems) {
    stderr.writeln(p);
  }
  stderr.writeln('\n불일치 ${problems.length}건');
  exit(1);
}
