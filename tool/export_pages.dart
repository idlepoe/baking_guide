// 원본 교재 사진을 EXIF 방향대로 편 뒤 읽기 좋은 크기로 내보낸다.
// 배합표·공정 내용을 원본과 대조할 때 사용한다.
//
//   dart run tool/export_pages.dart <한글폴더명> [출력폴더]

import 'dart:io';

import 'package:image/image.dart' as img;

const _rawRoot = 'assets/raw_images';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: dart run tool/export_pages.dart <한글폴더명> [출력폴더]');
    exit(64);
  }
  final name = args[0];
  final outDir = Directory(args.length > 1 ? args[1] : 'build/pages/$name')
    ..createSync(recursive: true);

  final src = Directory('$_rawRoot/$name');
  if (!src.existsSync()) {
    stderr.writeln('원본 폴더 없음: ${src.path}');
    exit(1);
  }

  final files = src.listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  var i = 0;
  for (final file in files) {
    final decoded = img.decodeImage(file.readAsBytesSync());
    if (decoded == null) {
      stderr.writeln('디코드 실패: ${file.path}');
      continue;
    }
    i++;
    final resized = img.copyResize(decoded, width: 1600);
    File('${outDir.path}/p$i.png').writeAsBytesSync(img.encodePng(resized));
  }
  stdout.writeln('$i장 → ${outDir.path}');
}
