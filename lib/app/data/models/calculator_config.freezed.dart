// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalculatorConfig {

 CalculatorKind get type; CalculatorParams get params;
/// Create a copy of CalculatorConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatorConfigCopyWith<CalculatorConfig> get copyWith => _$CalculatorConfigCopyWithImpl<CalculatorConfig>(this as CalculatorConfig, _$identity);

  /// Serializes this CalculatorConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatorConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,params);

@override
String toString() {
  return 'CalculatorConfig(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class $CalculatorConfigCopyWith<$Res>  {
  factory $CalculatorConfigCopyWith(CalculatorConfig value, $Res Function(CalculatorConfig) _then) = _$CalculatorConfigCopyWithImpl;
@useResult
$Res call({
 CalculatorKind type, CalculatorParams params
});


$CalculatorParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$CalculatorConfigCopyWithImpl<$Res>
    implements $CalculatorConfigCopyWith<$Res> {
  _$CalculatorConfigCopyWithImpl(this._self, this._then);

  final CalculatorConfig _self;
  final $Res Function(CalculatorConfig) _then;

/// Create a copy of CalculatorConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? params = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CalculatorKind,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as CalculatorParams,
  ));
}
/// Create a copy of CalculatorConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalculatorParamsCopyWith<$Res> get params {
  
  return $CalculatorParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalculatorConfig].
extension CalculatorConfigPatterns on CalculatorConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculatorConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculatorConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculatorConfig value)  $default,){
final _that = this;
switch (_that) {
case _CalculatorConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculatorConfig value)?  $default,){
final _that = this;
switch (_that) {
case _CalculatorConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalculatorKind type,  CalculatorParams params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatorConfig() when $default != null:
return $default(_that.type,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalculatorKind type,  CalculatorParams params)  $default,) {final _that = this;
switch (_that) {
case _CalculatorConfig():
return $default(_that.type,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalculatorKind type,  CalculatorParams params)?  $default,) {final _that = this;
switch (_that) {
case _CalculatorConfig() when $default != null:
return $default(_that.type,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculatorConfig implements CalculatorConfig {
  const _CalculatorConfig({required this.type, this.params = const CalculatorParams()});
  factory _CalculatorConfig.fromJson(Map<String, dynamic> json) => _$CalculatorConfigFromJson(json);

@override final  CalculatorKind type;
@override@JsonKey() final  CalculatorParams params;

/// Create a copy of CalculatorConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatorConfigCopyWith<_CalculatorConfig> get copyWith => __$CalculatorConfigCopyWithImpl<_CalculatorConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculatorConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatorConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,params);

@override
String toString() {
  return 'CalculatorConfig(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class _$CalculatorConfigCopyWith<$Res> implements $CalculatorConfigCopyWith<$Res> {
  factory _$CalculatorConfigCopyWith(_CalculatorConfig value, $Res Function(_CalculatorConfig) _then) = __$CalculatorConfigCopyWithImpl;
@override @useResult
$Res call({
 CalculatorKind type, CalculatorParams params
});


@override $CalculatorParamsCopyWith<$Res> get params;

}
/// @nodoc
class __$CalculatorConfigCopyWithImpl<$Res>
    implements _$CalculatorConfigCopyWith<$Res> {
  __$CalculatorConfigCopyWithImpl(this._self, this._then);

  final _CalculatorConfig _self;
  final $Res Function(_CalculatorConfig) _then;

/// Create a copy of CalculatorConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? params = null,}) {
  return _then(_CalculatorConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CalculatorKind,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as CalculatorParams,
  ));
}

/// Create a copy of CalculatorConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalculatorParamsCopyWith<$Res> get params {
  
  return $CalculatorParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

// dart format on
