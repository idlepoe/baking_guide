// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_ingredient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeIngredient {

 String get name; num get amount; String get unit; IngredientCategory get category; bool get required; num? get maxAmount;
/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeIngredientCopyWith<RecipeIngredient> get copyWith => _$RecipeIngredientCopyWithImpl<RecipeIngredient>(this as RecipeIngredient, _$identity);

  /// Serializes this RecipeIngredient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeIngredient&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category)&&(identical(other.required, required) || other.required == required)&&(identical(other.maxAmount, maxAmount) || other.maxAmount == maxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amount,unit,category,required,maxAmount);

@override
String toString() {
  return 'RecipeIngredient(name: $name, amount: $amount, unit: $unit, category: $category, required: $required, maxAmount: $maxAmount)';
}


}

/// @nodoc
abstract mixin class $RecipeIngredientCopyWith<$Res>  {
  factory $RecipeIngredientCopyWith(RecipeIngredient value, $Res Function(RecipeIngredient) _then) = _$RecipeIngredientCopyWithImpl;
@useResult
$Res call({
 String name, num amount, String unit, IngredientCategory category, bool required, num? maxAmount
});




}
/// @nodoc
class _$RecipeIngredientCopyWithImpl<$Res>
    implements $RecipeIngredientCopyWith<$Res> {
  _$RecipeIngredientCopyWithImpl(this._self, this._then);

  final RecipeIngredient _self;
  final $Res Function(RecipeIngredient) _then;

/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amount = null,Object? unit = null,Object? category = null,Object? required = null,Object? maxAmount = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as IngredientCategory,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,maxAmount: freezed == maxAmount ? _self.maxAmount : maxAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeIngredient].
extension RecipeIngredientPatterns on RecipeIngredient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeIngredient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeIngredient value)  $default,){
final _that = this;
switch (_that) {
case _RecipeIngredient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeIngredient value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  num amount,  String unit,  IngredientCategory category,  bool required,  num? maxAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
return $default(_that.name,_that.amount,_that.unit,_that.category,_that.required,_that.maxAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  num amount,  String unit,  IngredientCategory category,  bool required,  num? maxAmount)  $default,) {final _that = this;
switch (_that) {
case _RecipeIngredient():
return $default(_that.name,_that.amount,_that.unit,_that.category,_that.required,_that.maxAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  num amount,  String unit,  IngredientCategory category,  bool required,  num? maxAmount)?  $default,) {final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
return $default(_that.name,_that.amount,_that.unit,_that.category,_that.required,_that.maxAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeIngredient implements RecipeIngredient {
  const _RecipeIngredient({required this.name, required this.amount, required this.unit, required this.category, this.required = true, this.maxAmount});
  factory _RecipeIngredient.fromJson(Map<String, dynamic> json) => _$RecipeIngredientFromJson(json);

@override final  String name;
@override final  num amount;
@override final  String unit;
@override final  IngredientCategory category;
@override@JsonKey() final  bool required;
@override final  num? maxAmount;

/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeIngredientCopyWith<_RecipeIngredient> get copyWith => __$RecipeIngredientCopyWithImpl<_RecipeIngredient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeIngredientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeIngredient&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category)&&(identical(other.required, required) || other.required == required)&&(identical(other.maxAmount, maxAmount) || other.maxAmount == maxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amount,unit,category,required,maxAmount);

@override
String toString() {
  return 'RecipeIngredient(name: $name, amount: $amount, unit: $unit, category: $category, required: $required, maxAmount: $maxAmount)';
}


}

/// @nodoc
abstract mixin class _$RecipeIngredientCopyWith<$Res> implements $RecipeIngredientCopyWith<$Res> {
  factory _$RecipeIngredientCopyWith(_RecipeIngredient value, $Res Function(_RecipeIngredient) _then) = __$RecipeIngredientCopyWithImpl;
@override @useResult
$Res call({
 String name, num amount, String unit, IngredientCategory category, bool required, num? maxAmount
});




}
/// @nodoc
class __$RecipeIngredientCopyWithImpl<$Res>
    implements _$RecipeIngredientCopyWith<$Res> {
  __$RecipeIngredientCopyWithImpl(this._self, this._then);

  final _RecipeIngredient _self;
  final $Res Function(_RecipeIngredient) _then;

/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amount = null,Object? unit = null,Object? category = null,Object? required = null,Object? maxAmount = freezed,}) {
  return _then(_RecipeIngredient(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as IngredientCategory,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,maxAmount: freezed == maxAmount ? _self.maxAmount : maxAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
