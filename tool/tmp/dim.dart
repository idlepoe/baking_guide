import 'dart:io';
import 'package:image/image.dart' as img;
void main(List<String> a){
  final i = img.decodeImage(File(a[0]).readAsBytesSync())!;
  print('${i.width}x${i.height}');
}
