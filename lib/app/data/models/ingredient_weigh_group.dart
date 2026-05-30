import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_weigh_group.freezed.dart';
part 'ingredient_weigh_group.g.dart';

@freezed
abstract class IngredientWeighGroup with _$IngredientWeighGroup {
  const factory IngredientWeighGroup({
    required String id,
    required String label,
  }) = _IngredientWeighGroup;

  factory IngredientWeighGroup.fromJson(Map<String, dynamic> json) =>
      _$IngredientWeighGroupFromJson(json);
}
