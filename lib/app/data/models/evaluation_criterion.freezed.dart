// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation_criterion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EvaluationCriterion {

 String get id; String get text;
/// Create a copy of EvaluationCriterion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvaluationCriterionCopyWith<EvaluationCriterion> get copyWith => _$EvaluationCriterionCopyWithImpl<EvaluationCriterion>(this as EvaluationCriterion, _$identity);

  /// Serializes this EvaluationCriterion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvaluationCriterion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text);

@override
String toString() {
  return 'EvaluationCriterion(id: $id, text: $text)';
}


}

/// @nodoc
abstract mixin class $EvaluationCriterionCopyWith<$Res>  {
  factory $EvaluationCriterionCopyWith(EvaluationCriterion value, $Res Function(EvaluationCriterion) _then) = _$EvaluationCriterionCopyWithImpl;
@useResult
$Res call({
 String id, String text
});




}
/// @nodoc
class _$EvaluationCriterionCopyWithImpl<$Res>
    implements $EvaluationCriterionCopyWith<$Res> {
  _$EvaluationCriterionCopyWithImpl(this._self, this._then);

  final EvaluationCriterion _self;
  final $Res Function(EvaluationCriterion) _then;

/// Create a copy of EvaluationCriterion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EvaluationCriterion].
extension EvaluationCriterionPatterns on EvaluationCriterion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvaluationCriterion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvaluationCriterion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvaluationCriterion value)  $default,){
final _that = this;
switch (_that) {
case _EvaluationCriterion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvaluationCriterion value)?  $default,){
final _that = this;
switch (_that) {
case _EvaluationCriterion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvaluationCriterion() when $default != null:
return $default(_that.id,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text)  $default,) {final _that = this;
switch (_that) {
case _EvaluationCriterion():
return $default(_that.id,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text)?  $default,) {final _that = this;
switch (_that) {
case _EvaluationCriterion() when $default != null:
return $default(_that.id,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvaluationCriterion implements EvaluationCriterion {
  const _EvaluationCriterion({required this.id, required this.text});
  factory _EvaluationCriterion.fromJson(Map<String, dynamic> json) => _$EvaluationCriterionFromJson(json);

@override final  String id;
@override final  String text;

/// Create a copy of EvaluationCriterion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvaluationCriterionCopyWith<_EvaluationCriterion> get copyWith => __$EvaluationCriterionCopyWithImpl<_EvaluationCriterion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvaluationCriterionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvaluationCriterion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text);

@override
String toString() {
  return 'EvaluationCriterion(id: $id, text: $text)';
}


}

/// @nodoc
abstract mixin class _$EvaluationCriterionCopyWith<$Res> implements $EvaluationCriterionCopyWith<$Res> {
  factory _$EvaluationCriterionCopyWith(_EvaluationCriterion value, $Res Function(_EvaluationCriterion) _then) = __$EvaluationCriterionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text
});




}
/// @nodoc
class __$EvaluationCriterionCopyWithImpl<$Res>
    implements _$EvaluationCriterionCopyWith<$Res> {
  __$EvaluationCriterionCopyWithImpl(this._self, this._then);

  final _EvaluationCriterion _self;
  final $Res Function(_EvaluationCriterion) _then;

/// Create a copy of EvaluationCriterion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,}) {
  return _then(_EvaluationCriterion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
