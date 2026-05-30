import '../../data/models/enums/exam_type.dart';

String formatExamType(ExamType examType) {
  return switch (examType) {
    ExamType.baking => '제빵',
    ExamType.confectionery => '제과',
  };
}
