// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionTimer {

 TimerKind get type; String get label; int get durationSec; String? get startedAt; int get elapsedSec;
/// Create a copy of SessionTimer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionTimerCopyWith<SessionTimer> get copyWith => _$SessionTimerCopyWithImpl<SessionTimer>(this as SessionTimer, _$identity);

  /// Serializes this SessionTimer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionTimer&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.elapsedSec, elapsedSec) || other.elapsedSec == elapsedSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,durationSec,startedAt,elapsedSec);

@override
String toString() {
  return 'SessionTimer(type: $type, label: $label, durationSec: $durationSec, startedAt: $startedAt, elapsedSec: $elapsedSec)';
}


}

/// @nodoc
abstract mixin class $SessionTimerCopyWith<$Res>  {
  factory $SessionTimerCopyWith(SessionTimer value, $Res Function(SessionTimer) _then) = _$SessionTimerCopyWithImpl;
@useResult
$Res call({
 TimerKind type, String label, int durationSec, String? startedAt, int elapsedSec
});




}
/// @nodoc
class _$SessionTimerCopyWithImpl<$Res>
    implements $SessionTimerCopyWith<$Res> {
  _$SessionTimerCopyWithImpl(this._self, this._then);

  final SessionTimer _self;
  final $Res Function(SessionTimer) _then;

/// Create a copy of SessionTimer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? label = null,Object? durationSec = null,Object? startedAt = freezed,Object? elapsedSec = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimerKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,elapsedSec: null == elapsedSec ? _self.elapsedSec : elapsedSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionTimer].
extension SessionTimerPatterns on SessionTimer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionTimer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionTimer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionTimer value)  $default,){
final _that = this;
switch (_that) {
case _SessionTimer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionTimer value)?  $default,){
final _that = this;
switch (_that) {
case _SessionTimer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimerKind type,  String label,  int durationSec,  String? startedAt,  int elapsedSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionTimer() when $default != null:
return $default(_that.type,_that.label,_that.durationSec,_that.startedAt,_that.elapsedSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimerKind type,  String label,  int durationSec,  String? startedAt,  int elapsedSec)  $default,) {final _that = this;
switch (_that) {
case _SessionTimer():
return $default(_that.type,_that.label,_that.durationSec,_that.startedAt,_that.elapsedSec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimerKind type,  String label,  int durationSec,  String? startedAt,  int elapsedSec)?  $default,) {final _that = this;
switch (_that) {
case _SessionTimer() when $default != null:
return $default(_that.type,_that.label,_that.durationSec,_that.startedAt,_that.elapsedSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionTimer implements SessionTimer {
  const _SessionTimer({required this.type, required this.label, required this.durationSec, this.startedAt, this.elapsedSec = 0});
  factory _SessionTimer.fromJson(Map<String, dynamic> json) => _$SessionTimerFromJson(json);

@override final  TimerKind type;
@override final  String label;
@override final  int durationSec;
@override final  String? startedAt;
@override@JsonKey() final  int elapsedSec;

/// Create a copy of SessionTimer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionTimerCopyWith<_SessionTimer> get copyWith => __$SessionTimerCopyWithImpl<_SessionTimer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionTimerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionTimer&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.elapsedSec, elapsedSec) || other.elapsedSec == elapsedSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,durationSec,startedAt,elapsedSec);

@override
String toString() {
  return 'SessionTimer(type: $type, label: $label, durationSec: $durationSec, startedAt: $startedAt, elapsedSec: $elapsedSec)';
}


}

/// @nodoc
abstract mixin class _$SessionTimerCopyWith<$Res> implements $SessionTimerCopyWith<$Res> {
  factory _$SessionTimerCopyWith(_SessionTimer value, $Res Function(_SessionTimer) _then) = __$SessionTimerCopyWithImpl;
@override @useResult
$Res call({
 TimerKind type, String label, int durationSec, String? startedAt, int elapsedSec
});




}
/// @nodoc
class __$SessionTimerCopyWithImpl<$Res>
    implements _$SessionTimerCopyWith<$Res> {
  __$SessionTimerCopyWithImpl(this._self, this._then);

  final _SessionTimer _self;
  final $Res Function(_SessionTimer) _then;

/// Create a copy of SessionTimer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,Object? durationSec = null,Object? startedAt = freezed,Object? elapsedSec = null,}) {
  return _then(_SessionTimer(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimerKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,elapsedSec: null == elapsedSec ? _self.elapsedSec : elapsedSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
