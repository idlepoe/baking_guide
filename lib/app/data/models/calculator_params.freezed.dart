// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalculatorParams {

 num? get target;
/// Create a copy of CalculatorParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatorParamsCopyWith<CalculatorParams> get copyWith => _$CalculatorParamsCopyWithImpl<CalculatorParams>(this as CalculatorParams, _$identity);

  /// Serializes this CalculatorParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatorParams&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target);

@override
String toString() {
  return 'CalculatorParams(target: $target)';
}


}

/// @nodoc
abstract mixin class $CalculatorParamsCopyWith<$Res>  {
  factory $CalculatorParamsCopyWith(CalculatorParams value, $Res Function(CalculatorParams) _then) = _$CalculatorParamsCopyWithImpl;
@useResult
$Res call({
 num? target
});




}
/// @nodoc
class _$CalculatorParamsCopyWithImpl<$Res>
    implements $CalculatorParamsCopyWith<$Res> {
  _$CalculatorParamsCopyWithImpl(this._self, this._then);

  final CalculatorParams _self;
  final $Res Function(CalculatorParams) _then;

/// Create a copy of CalculatorParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = freezed,}) {
  return _then(_self.copyWith(
target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculatorParams].
extension CalculatorParamsPatterns on CalculatorParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculatorParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculatorParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculatorParams value)  $default,){
final _that = this;
switch (_that) {
case _CalculatorParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculatorParams value)?  $default,){
final _that = this;
switch (_that) {
case _CalculatorParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num? target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatorParams() when $default != null:
return $default(_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num? target)  $default,) {final _that = this;
switch (_that) {
case _CalculatorParams():
return $default(_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num? target)?  $default,) {final _that = this;
switch (_that) {
case _CalculatorParams() when $default != null:
return $default(_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculatorParams implements CalculatorParams {
  const _CalculatorParams({this.target});
  factory _CalculatorParams.fromJson(Map<String, dynamic> json) => _$CalculatorParamsFromJson(json);

@override final  num? target;

/// Create a copy of CalculatorParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatorParamsCopyWith<_CalculatorParams> get copyWith => __$CalculatorParamsCopyWithImpl<_CalculatorParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculatorParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatorParams&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target);

@override
String toString() {
  return 'CalculatorParams(target: $target)';
}


}

/// @nodoc
abstract mixin class _$CalculatorParamsCopyWith<$Res> implements $CalculatorParamsCopyWith<$Res> {
  factory _$CalculatorParamsCopyWith(_CalculatorParams value, $Res Function(_CalculatorParams) _then) = __$CalculatorParamsCopyWithImpl;
@override @useResult
$Res call({
 num? target
});




}
/// @nodoc
class __$CalculatorParamsCopyWithImpl<$Res>
    implements _$CalculatorParamsCopyWith<$Res> {
  __$CalculatorParamsCopyWithImpl(this._self, this._then);

  final _CalculatorParams _self;
  final $Res Function(_CalculatorParams) _then;

/// Create a copy of CalculatorParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = freezed,}) {
  return _then(_CalculatorParams(
target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
