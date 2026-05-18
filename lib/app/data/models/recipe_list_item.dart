import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_list_item.freezed.dart';
part 'recipe_list_item.g.dart';

@freezed
abstract class RecipeListItem with _$RecipeListItem {
  const factory RecipeListItem({
    required String id,
    required String name,
    required String category,
    @Default('') String thumbnailUrl,
    required int difficulty,
    required int totalTimeSec,
  }) = _RecipeListItem;

  factory RecipeListItem.fromJson(Map<String, dynamic> json) =>
      _$RecipeListItemFromJson(json);
}
