import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_point_group.freezed.dart';
part 'key_point_group.g.dart';

@freezed
abstract class KeyPointGroup with _$KeyPointGroup {
  const factory KeyPointGroup({
    required String title,
    @Default([]) List<String> items,
  }) = _KeyPointGroup;

  factory KeyPointGroup.fromJson(Map<String, dynamic> json) =>
      _$KeyPointGroupFromJson(json);
}
