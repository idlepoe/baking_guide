// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oven_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OvenSetting {

 int get top; int get bottom; TemperatureUnit get unit;
/// Create a copy of OvenSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OvenSettingCopyWith<OvenSetting> get copyWith => _$OvenSettingCopyWithImpl<OvenSetting>(this as OvenSetting, _$identity);

  /// Serializes this OvenSetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OvenSetting&&(identical(other.top, top) || other.top == top)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,top,bottom,unit);

@override
String toString() {
  return 'OvenSetting(top: $top, bottom: $bottom, unit: $unit)';
}


}

/// @nodoc
abstract mixin class $OvenSettingCopyWith<$Res>  {
  factory $OvenSettingCopyWith(OvenSetting value, $Res Function(OvenSetting) _then) = _$OvenSettingCopyWithImpl;
@useResult
$Res call({
 int top, int bottom, TemperatureUnit unit
});




}
/// @nodoc
class _$OvenSettingCopyWithImpl<$Res>
    implements $OvenSettingCopyWith<$Res> {
  _$OvenSettingCopyWithImpl(this._self, this._then);

  final OvenSetting _self;
  final $Res Function(OvenSetting) _then;

/// Create a copy of OvenSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? top = null,Object? bottom = null,Object? unit = null,}) {
  return _then(_self.copyWith(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as int,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as int,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as TemperatureUnit,
  ));
}

}


/// Adds pattern-matching-related methods to [OvenSetting].
extension OvenSettingPatterns on OvenSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OvenSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OvenSetting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OvenSetting value)  $default,){
final _that = this;
switch (_that) {
case _OvenSetting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OvenSetting value)?  $default,){
final _that = this;
switch (_that) {
case _OvenSetting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int top,  int bottom,  TemperatureUnit unit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OvenSetting() when $default != null:
return $default(_that.top,_that.bottom,_that.unit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int top,  int bottom,  TemperatureUnit unit)  $default,) {final _that = this;
switch (_that) {
case _OvenSetting():
return $default(_that.top,_that.bottom,_that.unit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int top,  int bottom,  TemperatureUnit unit)?  $default,) {final _that = this;
switch (_that) {
case _OvenSetting() when $default != null:
return $default(_that.top,_that.bottom,_that.unit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OvenSetting implements OvenSetting {
  const _OvenSetting({required this.top, required this.bottom, this.unit = TemperatureUnit.celsius});
  factory _OvenSetting.fromJson(Map<String, dynamic> json) => _$OvenSettingFromJson(json);

@override final  int top;
@override final  int bottom;
@override@JsonKey() final  TemperatureUnit unit;

/// Create a copy of OvenSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OvenSettingCopyWith<_OvenSetting> get copyWith => __$OvenSettingCopyWithImpl<_OvenSetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OvenSettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OvenSetting&&(identical(other.top, top) || other.top == top)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,top,bottom,unit);

@override
String toString() {
  return 'OvenSetting(top: $top, bottom: $bottom, unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$OvenSettingCopyWith<$Res> implements $OvenSettingCopyWith<$Res> {
  factory _$OvenSettingCopyWith(_OvenSetting value, $Res Function(_OvenSetting) _then) = __$OvenSettingCopyWithImpl;
@override @useResult
$Res call({
 int top, int bottom, TemperatureUnit unit
});




}
/// @nodoc
class __$OvenSettingCopyWithImpl<$Res>
    implements _$OvenSettingCopyWith<$Res> {
  __$OvenSettingCopyWithImpl(this._self, this._then);

  final _OvenSetting _self;
  final $Res Function(_OvenSetting) _then;

/// Create a copy of OvenSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? top = null,Object? bottom = null,Object? unit = null,}) {
  return _then(_OvenSetting(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as int,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as int,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as TemperatureUnit,
  ));
}


}

// dart format on
