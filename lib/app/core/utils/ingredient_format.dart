import '../../data/models/recipe_ingredient.dart';

/// 배합 배율. [exam]이면 JSON 계량 그대로, 그 외는 재료별 amount에 배율만 적용.
enum IngredientBatchScale {
  quarter(0.25, '1/4'),
  half(0.5, '1/2'),
  exam(1.0, '실기 기준');

  const IngredientBatchScale(this.factor, this.label);

  final double factor;
  final String label;

  static IngredientBatchScale fromSliderIndex(int index) {
    return IngredientBatchScale.values[index.clamp(0, 2)];
  }
}

String formatIngredientAmount(RecipeIngredient ingredient) {
  return formatIngredientAmountForScale(
    ingredient,
    scale: IngredientBatchScale.exam,
  );
}

String formatIngredientAmountForScale(
  RecipeIngredient ingredient, {
  required IngredientBatchScale scale,
}) {
  final amount = ingredient.amount * scale.factor;
  final max = ingredient.maxAmount;
  if (max != null) {
    final scaledMax = max * scale.factor;
    return '${_formatAmount(amount)} ~ ${_formatAmount(scaledMax)} ${ingredient.unit}';
  }
  return '${_formatAmount(amount)} ${ingredient.unit}';
}

String _formatAmount(num value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toString();
}
