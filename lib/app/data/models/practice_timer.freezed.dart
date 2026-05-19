// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PracticeTimer {

 String get timerId; String get sessionId; TimerKind get type; int get durationSec;@IsoDateTimeConverter() DateTime get startedAt;@IsoDateTimeConverter() DateTime get endsAt; bool get notificationEnabled;
/// Create a copy of PracticeTimer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeTimerCopyWith<PracticeTimer> get copyWith => _$PracticeTimerCopyWithImpl<PracticeTimer>(this as PracticeTimer, _$identity);

  /// Serializes this PracticeTimer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeTimer&&(identical(other.timerId, timerId) || other.timerId == timerId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.type, type) || other.type == type)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timerId,sessionId,type,durationSec,startedAt,endsAt,notificationEnabled);

@override
String toString() {
  return 'PracticeTimer(timerId: $timerId, sessionId: $sessionId, type: $type, durationSec: $durationSec, startedAt: $startedAt, endsAt: $endsAt, notificationEnabled: $notificationEnabled)';
}


}

/// @nodoc
abstract mixin class $PracticeTimerCopyWith<$Res>  {
  factory $PracticeTimerCopyWith(PracticeTimer value, $Res Function(PracticeTimer) _then) = _$PracticeTimerCopyWithImpl;
@useResult
$Res call({
 String timerId, String sessionId, TimerKind type, int durationSec,@IsoDateTimeConverter() DateTime startedAt,@IsoDateTimeConverter() DateTime endsAt, bool notificationEnabled
});




}
/// @nodoc
class _$PracticeTimerCopyWithImpl<$Res>
    implements $PracticeTimerCopyWith<$Res> {
  _$PracticeTimerCopyWithImpl(this._self, this._then);

  final PracticeTimer _self;
  final $Res Function(PracticeTimer) _then;

/// Create a copy of PracticeTimer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timerId = null,Object? sessionId = null,Object? type = null,Object? durationSec = null,Object? startedAt = null,Object? endsAt = null,Object? notificationEnabled = null,}) {
  return _then(_self.copyWith(
timerId: null == timerId ? _self.timerId : timerId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimerKind,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeTimer].
extension PracticeTimerPatterns on PracticeTimer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeTimer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeTimer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeTimer value)  $default,){
final _that = this;
switch (_that) {
case _PracticeTimer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeTimer value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeTimer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String timerId,  String sessionId,  TimerKind type,  int durationSec, @IsoDateTimeConverter()  DateTime startedAt, @IsoDateTimeConverter()  DateTime endsAt,  bool notificationEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeTimer() when $default != null:
return $default(_that.timerId,_that.sessionId,_that.type,_that.durationSec,_that.startedAt,_that.endsAt,_that.notificationEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String timerId,  String sessionId,  TimerKind type,  int durationSec, @IsoDateTimeConverter()  DateTime startedAt, @IsoDateTimeConverter()  DateTime endsAt,  bool notificationEnabled)  $default,) {final _that = this;
switch (_that) {
case _PracticeTimer():
return $default(_that.timerId,_that.sessionId,_that.type,_that.durationSec,_that.startedAt,_that.endsAt,_that.notificationEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String timerId,  String sessionId,  TimerKind type,  int durationSec, @IsoDateTimeConverter()  DateTime startedAt, @IsoDateTimeConverter()  DateTime endsAt,  bool notificationEnabled)?  $default,) {final _that = this;
switch (_that) {
case _PracticeTimer() when $default != null:
return $default(_that.timerId,_that.sessionId,_that.type,_that.durationSec,_that.startedAt,_that.endsAt,_that.notificationEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeTimer implements PracticeTimer {
  const _PracticeTimer({required this.timerId, required this.sessionId, required this.type, required this.durationSec, @IsoDateTimeConverter() required this.startedAt, @IsoDateTimeConverter() required this.endsAt, this.notificationEnabled = true});
  factory _PracticeTimer.fromJson(Map<String, dynamic> json) => _$PracticeTimerFromJson(json);

@override final  String timerId;
@override final  String sessionId;
@override final  TimerKind type;
@override final  int durationSec;
@override@IsoDateTimeConverter() final  DateTime startedAt;
@override@IsoDateTimeConverter() final  DateTime endsAt;
@override@JsonKey() final  bool notificationEnabled;

/// Create a copy of PracticeTimer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeTimerCopyWith<_PracticeTimer> get copyWith => __$PracticeTimerCopyWithImpl<_PracticeTimer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeTimerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeTimer&&(identical(other.timerId, timerId) || other.timerId == timerId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.type, type) || other.type == type)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timerId,sessionId,type,durationSec,startedAt,endsAt,notificationEnabled);

@override
String toString() {
  return 'PracticeTimer(timerId: $timerId, sessionId: $sessionId, type: $type, durationSec: $durationSec, startedAt: $startedAt, endsAt: $endsAt, notificationEnabled: $notificationEnabled)';
}


}

/// @nodoc
abstract mixin class _$PracticeTimerCopyWith<$Res> implements $PracticeTimerCopyWith<$Res> {
  factory _$PracticeTimerCopyWith(_PracticeTimer value, $Res Function(_PracticeTimer) _then) = __$PracticeTimerCopyWithImpl;
@override @useResult
$Res call({
 String timerId, String sessionId, TimerKind type, int durationSec,@IsoDateTimeConverter() DateTime startedAt,@IsoDateTimeConverter() DateTime endsAt, bool notificationEnabled
});




}
/// @nodoc
class __$PracticeTimerCopyWithImpl<$Res>
    implements _$PracticeTimerCopyWith<$Res> {
  __$PracticeTimerCopyWithImpl(this._self, this._then);

  final _PracticeTimer _self;
  final $Res Function(_PracticeTimer) _then;

/// Create a copy of PracticeTimer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timerId = null,Object? sessionId = null,Object? type = null,Object? durationSec = null,Object? startedAt = null,Object? endsAt = null,Object? notificationEnabled = null,}) {
  return _then(_PracticeTimer(
timerId: null == timerId ? _self.timerId : timerId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimerKind,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
