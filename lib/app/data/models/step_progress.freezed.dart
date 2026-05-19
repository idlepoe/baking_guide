// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepProgress {

 int get stepNo;@IsoDateTimeConverter() DateTime get startedAt;
/// Create a copy of StepProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepProgressCopyWith<StepProgress> get copyWith => _$StepProgressCopyWithImpl<StepProgress>(this as StepProgress, _$identity);

  /// Serializes this StepProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepProgress&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stepNo,startedAt);

@override
String toString() {
  return 'StepProgress(stepNo: $stepNo, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $StepProgressCopyWith<$Res>  {
  factory $StepProgressCopyWith(StepProgress value, $Res Function(StepProgress) _then) = _$StepProgressCopyWithImpl;
@useResult
$Res call({
 int stepNo,@IsoDateTimeConverter() DateTime startedAt
});




}
/// @nodoc
class _$StepProgressCopyWithImpl<$Res>
    implements $StepProgressCopyWith<$Res> {
  _$StepProgressCopyWithImpl(this._self, this._then);

  final StepProgress _self;
  final $Res Function(StepProgress) _then;

/// Create a copy of StepProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNo = null,Object? startedAt = null,}) {
  return _then(_self.copyWith(
stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StepProgress].
extension StepProgressPatterns on StepProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepProgress value)  $default,){
final _that = this;
switch (_that) {
case _StepProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepProgress value)?  $default,){
final _that = this;
switch (_that) {
case _StepProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNo, @IsoDateTimeConverter()  DateTime startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepProgress() when $default != null:
return $default(_that.stepNo,_that.startedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNo, @IsoDateTimeConverter()  DateTime startedAt)  $default,) {final _that = this;
switch (_that) {
case _StepProgress():
return $default(_that.stepNo,_that.startedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNo, @IsoDateTimeConverter()  DateTime startedAt)?  $default,) {final _that = this;
switch (_that) {
case _StepProgress() when $default != null:
return $default(_that.stepNo,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepProgress implements StepProgress {
  const _StepProgress({required this.stepNo, @IsoDateTimeConverter() required this.startedAt});
  factory _StepProgress.fromJson(Map<String, dynamic> json) => _$StepProgressFromJson(json);

@override final  int stepNo;
@override@IsoDateTimeConverter() final  DateTime startedAt;

/// Create a copy of StepProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepProgressCopyWith<_StepProgress> get copyWith => __$StepProgressCopyWithImpl<_StepProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepProgress&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stepNo,startedAt);

@override
String toString() {
  return 'StepProgress(stepNo: $stepNo, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$StepProgressCopyWith<$Res> implements $StepProgressCopyWith<$Res> {
  factory _$StepProgressCopyWith(_StepProgress value, $Res Function(_StepProgress) _then) = __$StepProgressCopyWithImpl;
@override @useResult
$Res call({
 int stepNo,@IsoDateTimeConverter() DateTime startedAt
});




}
/// @nodoc
class __$StepProgressCopyWithImpl<$Res>
    implements _$StepProgressCopyWith<$Res> {
  __$StepProgressCopyWithImpl(this._self, this._then);

  final _StepProgress _self;
  final $Res Function(_StepProgress) _then;

/// Create a copy of StepProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNo = null,Object? startedAt = null,}) {
  return _then(_StepProgress(
stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
