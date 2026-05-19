import '../../data/models/recipe_ingredient.dart';

String formatIngredientAmount(RecipeIngredient ingredient) {
  final amount = _formatAmount(ingredient.amount);
  final max = ingredient.maxAmount;
  if (max != null) {
    return '$amount ~ ${_formatAmount(max)} ${ingredient.unit}';
  }
  return '$amount ${ingredient.unit}';
}

String _formatAmount(num value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toString();
}
