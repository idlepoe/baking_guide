// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepTimer {

 TimerKind get type; String get label; int get durationSec;
/// Create a copy of StepTimer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepTimerCopyWith<StepTimer> get copyWith => _$StepTimerCopyWithImpl<StepTimer>(this as StepTimer, _$identity);

  /// Serializes this StepTimer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepTimer&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,durationSec);

@override
String toString() {
  return 'StepTimer(type: $type, label: $label, durationSec: $durationSec)';
}


}

/// @nodoc
abstract mixin class $StepTimerCopyWith<$Res>  {
  factory $StepTimerCopyWith(StepTimer value, $Res Function(StepTimer) _then) = _$StepTimerCopyWithImpl;
@useResult
$Res call({
 TimerKind type, String label, int durationSec
});




}
/// @nodoc
class _$StepTimerCopyWithImpl<$Res>
    implements $StepTimerCopyWith<$Res> {
  _$StepTimerCopyWithImpl(this._self, this._then);

  final StepTimer _self;
  final $Res Function(StepTimer) _then;

/// Create a copy of StepTimer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? label = null,Object? durationSec = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimerKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StepTimer].
extension StepTimerPatterns on StepTimer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepTimer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepTimer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepTimer value)  $default,){
final _that = this;
switch (_that) {
case _StepTimer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepTimer value)?  $default,){
final _that = this;
switch (_that) {
case _StepTimer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimerKind type,  String label,  int durationSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepTimer() when $default != null:
return $default(_that.type,_that.label,_that.durationSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimerKind type,  String label,  int durationSec)  $default,) {final _that = this;
switch (_that) {
case _StepTimer():
return $default(_that.type,_that.label,_that.durationSec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimerKind type,  String label,  int durationSec)?  $default,) {final _that = this;
switch (_that) {
case _StepTimer() when $default != null:
return $default(_that.type,_that.label,_that.durationSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepTimer implements StepTimer {
  const _StepTimer({required this.type, required this.label, required this.durationSec});
  factory _StepTimer.fromJson(Map<String, dynamic> json) => _$StepTimerFromJson(json);

@override final  TimerKind type;
@override final  String label;
@override final  int durationSec;

/// Create a copy of StepTimer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepTimerCopyWith<_StepTimer> get copyWith => __$StepTimerCopyWithImpl<_StepTimer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepTimerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepTimer&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,durationSec);

@override
String toString() {
  return 'StepTimer(type: $type, label: $label, durationSec: $durationSec)';
}


}

/// @nodoc
abstract mixin class _$StepTimerCopyWith<$Res> implements $StepTimerCopyWith<$Res> {
  factory _$StepTimerCopyWith(_StepTimer value, $Res Function(_StepTimer) _then) = __$StepTimerCopyWithImpl;
@override @useResult
$Res call({
 TimerKind type, String label, int durationSec
});




}
/// @nodoc
class __$StepTimerCopyWithImpl<$Res>
    implements _$StepTimerCopyWith<$Res> {
  __$StepTimerCopyWithImpl(this._self, this._then);

  final _StepTimer _self;
  final $Res Function(_StepTimer) _then;

/// Create a copy of StepTimer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,Object? durationSec = null,}) {
  return _then(_StepTimer(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimerKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
