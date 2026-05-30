// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeDetail {

 String get id; String get name; String get category; String get thumbnailUrl; RecipeSummary get summary; List<RecipeIngredient> get ingredients; List<IngredientWeighGroup> get weighGroups; List<RecipeStep> get steps; List<EvaluationCriterion> get resultEvaluation;
/// Create a copy of RecipeDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeDetailCopyWith<RecipeDetail> get copyWith => _$RecipeDetailCopyWithImpl<RecipeDetail>(this as RecipeDetail, _$identity);

  /// Serializes this RecipeDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&const DeepCollectionEquality().equals(other.weighGroups, weighGroups)&&const DeepCollectionEquality().equals(other.steps, steps)&&const DeepCollectionEquality().equals(other.resultEvaluation, resultEvaluation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,thumbnailUrl,summary,const DeepCollectionEquality().hash(ingredients),const DeepCollectionEquality().hash(weighGroups),const DeepCollectionEquality().hash(steps),const DeepCollectionEquality().hash(resultEvaluation));

@override
String toString() {
  return 'RecipeDetail(id: $id, name: $name, category: $category, thumbnailUrl: $thumbnailUrl, summary: $summary, ingredients: $ingredients, weighGroups: $weighGroups, steps: $steps, resultEvaluation: $resultEvaluation)';
}


}

/// @nodoc
abstract mixin class $RecipeDetailCopyWith<$Res>  {
  factory $RecipeDetailCopyWith(RecipeDetail value, $Res Function(RecipeDetail) _then) = _$RecipeDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String thumbnailUrl, RecipeSummary summary, List<RecipeIngredient> ingredients, List<IngredientWeighGroup> weighGroups, List<RecipeStep> steps, List<EvaluationCriterion> resultEvaluation
});


$RecipeSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$RecipeDetailCopyWithImpl<$Res>
    implements $RecipeDetailCopyWith<$Res> {
  _$RecipeDetailCopyWithImpl(this._self, this._then);

  final RecipeDetail _self;
  final $Res Function(RecipeDetail) _then;

/// Create a copy of RecipeDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? thumbnailUrl = null,Object? summary = null,Object? ingredients = null,Object? weighGroups = null,Object? steps = null,Object? resultEvaluation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as RecipeSummary,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredient>,weighGroups: null == weighGroups ? _self.weighGroups : weighGroups // ignore: cast_nullable_to_non_nullable
as List<IngredientWeighGroup>,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStep>,resultEvaluation: null == resultEvaluation ? _self.resultEvaluation : resultEvaluation // ignore: cast_nullable_to_non_nullable
as List<EvaluationCriterion>,
  ));
}
/// Create a copy of RecipeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeSummaryCopyWith<$Res> get summary {
  
  return $RecipeSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecipeDetail].
extension RecipeDetailPatterns on RecipeDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeDetail value)  $default,){
final _that = this;
switch (_that) {
case _RecipeDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeDetail value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String thumbnailUrl,  RecipeSummary summary,  List<RecipeIngredient> ingredients,  List<IngredientWeighGroup> weighGroups,  List<RecipeStep> steps,  List<EvaluationCriterion> resultEvaluation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeDetail() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.thumbnailUrl,_that.summary,_that.ingredients,_that.weighGroups,_that.steps,_that.resultEvaluation);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String thumbnailUrl,  RecipeSummary summary,  List<RecipeIngredient> ingredients,  List<IngredientWeighGroup> weighGroups,  List<RecipeStep> steps,  List<EvaluationCriterion> resultEvaluation)  $default,) {final _that = this;
switch (_that) {
case _RecipeDetail():
return $default(_that.id,_that.name,_that.category,_that.thumbnailUrl,_that.summary,_that.ingredients,_that.weighGroups,_that.steps,_that.resultEvaluation);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String thumbnailUrl,  RecipeSummary summary,  List<RecipeIngredient> ingredients,  List<IngredientWeighGroup> weighGroups,  List<RecipeStep> steps,  List<EvaluationCriterion> resultEvaluation)?  $default,) {final _that = this;
switch (_that) {
case _RecipeDetail() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.thumbnailUrl,_that.summary,_that.ingredients,_that.weighGroups,_that.steps,_that.resultEvaluation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeDetail implements RecipeDetail {
  const _RecipeDetail({required this.id, required this.name, required this.category, this.thumbnailUrl = '', required this.summary, final  List<RecipeIngredient> ingredients = const [], final  List<IngredientWeighGroup> weighGroups = const [], final  List<RecipeStep> steps = const [], final  List<EvaluationCriterion> resultEvaluation = const []}): _ingredients = ingredients,_weighGroups = weighGroups,_steps = steps,_resultEvaluation = resultEvaluation;
  factory _RecipeDetail.fromJson(Map<String, dynamic> json) => _$RecipeDetailFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override@JsonKey() final  String thumbnailUrl;
@override final  RecipeSummary summary;
 final  List<RecipeIngredient> _ingredients;
@override@JsonKey() List<RecipeIngredient> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}

 final  List<IngredientWeighGroup> _weighGroups;
@override@JsonKey() List<IngredientWeighGroup> get weighGroups {
  if (_weighGroups is EqualUnmodifiableListView) return _weighGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weighGroups);
}

 final  List<RecipeStep> _steps;
@override@JsonKey() List<RecipeStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<EvaluationCriterion> _resultEvaluation;
@override@JsonKey() List<EvaluationCriterion> get resultEvaluation {
  if (_resultEvaluation is EqualUnmodifiableListView) return _resultEvaluation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultEvaluation);
}


/// Create a copy of RecipeDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeDetailCopyWith<_RecipeDetail> get copyWith => __$RecipeDetailCopyWithImpl<_RecipeDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&const DeepCollectionEquality().equals(other._weighGroups, _weighGroups)&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._resultEvaluation, _resultEvaluation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,thumbnailUrl,summary,const DeepCollectionEquality().hash(_ingredients),const DeepCollectionEquality().hash(_weighGroups),const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_resultEvaluation));

@override
String toString() {
  return 'RecipeDetail(id: $id, name: $name, category: $category, thumbnailUrl: $thumbnailUrl, summary: $summary, ingredients: $ingredients, weighGroups: $weighGroups, steps: $steps, resultEvaluation: $resultEvaluation)';
}


}

/// @nodoc
abstract mixin class _$RecipeDetailCopyWith<$Res> implements $RecipeDetailCopyWith<$Res> {
  factory _$RecipeDetailCopyWith(_RecipeDetail value, $Res Function(_RecipeDetail) _then) = __$RecipeDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String thumbnailUrl, RecipeSummary summary, List<RecipeIngredient> ingredients, List<IngredientWeighGroup> weighGroups, List<RecipeStep> steps, List<EvaluationCriterion> resultEvaluation
});


@override $RecipeSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$RecipeDetailCopyWithImpl<$Res>
    implements _$RecipeDetailCopyWith<$Res> {
  __$RecipeDetailCopyWithImpl(this._self, this._then);

  final _RecipeDetail _self;
  final $Res Function(_RecipeDetail) _then;

/// Create a copy of RecipeDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? thumbnailUrl = null,Object? summary = null,Object? ingredients = null,Object? weighGroups = null,Object? steps = null,Object? resultEvaluation = null,}) {
  return _then(_RecipeDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as RecipeSummary,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredient>,weighGroups: null == weighGroups ? _self._weighGroups : weighGroups // ignore: cast_nullable_to_non_nullable
as List<IngredientWeighGroup>,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStep>,resultEvaluation: null == resultEvaluation ? _self._resultEvaluation : resultEvaluation // ignore: cast_nullable_to_non_nullable
as List<EvaluationCriterion>,
  ));
}

/// Create a copy of RecipeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeSummaryCopyWith<$Res> get summary {
  
  return $RecipeSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
