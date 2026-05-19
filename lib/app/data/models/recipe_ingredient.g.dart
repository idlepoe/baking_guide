// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) =>
    _RecipeIngredient(
      name: json['name'] as String,
      amount: json['amount'] as num,
      unit: json['unit'] as String,
      category: $enumDecode(_$IngredientCategoryEnumMap, json['category']),
      required: json['required'] as bool? ?? true,
      maxAmount: json['maxAmount'] as num?,
    );

Map<String, dynamic> _$RecipeIngredientToJson(_RecipeIngredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
      'category': _$IngredientCategoryEnumMap[instance.category]!,
      'required': instance.required,
      'maxAmount': instance.maxAmount,
    };

const _$IngredientCategoryEnumMap = {
  IngredientCategory.flour: 'flour',
  IngredientCategory.liquid: 'liquid',
  IngredientCategory.sweetener: 'sweetener',
  IngredientCategory.salt: 'salt',
  IngredientCategory.yeast: 'yeast',
  IngredientCategory.fat: 'fat',
  IngredientCategory.filling: 'filling',
};
