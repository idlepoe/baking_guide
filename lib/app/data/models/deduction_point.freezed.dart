// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deduction_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeductionPoint {

 DeductionSeverity get severity; String get text;
/// Create a copy of DeductionPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeductionPointCopyWith<DeductionPoint> get copyWith => _$DeductionPointCopyWithImpl<DeductionPoint>(this as DeductionPoint, _$identity);

  /// Serializes this DeductionPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeductionPoint&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,text);

@override
String toString() {
  return 'DeductionPoint(severity: $severity, text: $text)';
}


}

/// @nodoc
abstract mixin class $DeductionPointCopyWith<$Res>  {
  factory $DeductionPointCopyWith(DeductionPoint value, $Res Function(DeductionPoint) _then) = _$DeductionPointCopyWithImpl;
@useResult
$Res call({
 DeductionSeverity severity, String text
});




}
/// @nodoc
class _$DeductionPointCopyWithImpl<$Res>
    implements $DeductionPointCopyWith<$Res> {
  _$DeductionPointCopyWithImpl(this._self, this._then);

  final DeductionPoint _self;
  final $Res Function(DeductionPoint) _then;

/// Create a copy of DeductionPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? severity = null,Object? text = null,}) {
  return _then(_self.copyWith(
severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DeductionSeverity,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeductionPoint].
extension DeductionPointPatterns on DeductionPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeductionPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeductionPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeductionPoint value)  $default,){
final _that = this;
switch (_that) {
case _DeductionPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeductionPoint value)?  $default,){
final _that = this;
switch (_that) {
case _DeductionPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeductionSeverity severity,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeductionPoint() when $default != null:
return $default(_that.severity,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeductionSeverity severity,  String text)  $default,) {final _that = this;
switch (_that) {
case _DeductionPoint():
return $default(_that.severity,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeductionSeverity severity,  String text)?  $default,) {final _that = this;
switch (_that) {
case _DeductionPoint() when $default != null:
return $default(_that.severity,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeductionPoint implements DeductionPoint {
  const _DeductionPoint({required this.severity, required this.text});
  factory _DeductionPoint.fromJson(Map<String, dynamic> json) => _$DeductionPointFromJson(json);

@override final  DeductionSeverity severity;
@override final  String text;

/// Create a copy of DeductionPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeductionPointCopyWith<_DeductionPoint> get copyWith => __$DeductionPointCopyWithImpl<_DeductionPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeductionPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeductionPoint&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,text);

@override
String toString() {
  return 'DeductionPoint(severity: $severity, text: $text)';
}


}

/// @nodoc
abstract mixin class _$DeductionPointCopyWith<$Res> implements $DeductionPointCopyWith<$Res> {
  factory _$DeductionPointCopyWith(_DeductionPoint value, $Res Function(_DeductionPoint) _then) = __$DeductionPointCopyWithImpl;
@override @useResult
$Res call({
 DeductionSeverity severity, String text
});




}
/// @nodoc
class __$DeductionPointCopyWithImpl<$Res>
    implements _$DeductionPointCopyWith<$Res> {
  __$DeductionPointCopyWithImpl(this._self, this._then);

  final _DeductionPoint _self;
  final $Res Function(_DeductionPoint) _then;

/// Create a copy of DeductionPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? severity = null,Object? text = null,}) {
  return _then(_DeductionPoint(
severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DeductionSeverity,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
