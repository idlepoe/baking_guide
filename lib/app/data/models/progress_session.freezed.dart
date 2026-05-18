// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressSession {

 String get sessionId; String get recipeId; int get currentStep; List<String> get checkedItems; String get startedAt; List<SessionTimer> get timers;
/// Create a copy of ProgressSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressSessionCopyWith<ProgressSession> get copyWith => _$ProgressSessionCopyWithImpl<ProgressSession>(this as ProgressSession, _$identity);

  /// Serializes this ProgressSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&const DeepCollectionEquality().equals(other.checkedItems, checkedItems)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&const DeepCollectionEquality().equals(other.timers, timers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,recipeId,currentStep,const DeepCollectionEquality().hash(checkedItems),startedAt,const DeepCollectionEquality().hash(timers));

@override
String toString() {
  return 'ProgressSession(sessionId: $sessionId, recipeId: $recipeId, currentStep: $currentStep, checkedItems: $checkedItems, startedAt: $startedAt, timers: $timers)';
}


}

/// @nodoc
abstract mixin class $ProgressSessionCopyWith<$Res>  {
  factory $ProgressSessionCopyWith(ProgressSession value, $Res Function(ProgressSession) _then) = _$ProgressSessionCopyWithImpl;
@useResult
$Res call({
 String sessionId, String recipeId, int currentStep, List<String> checkedItems, String startedAt, List<SessionTimer> timers
});




}
/// @nodoc
class _$ProgressSessionCopyWithImpl<$Res>
    implements $ProgressSessionCopyWith<$Res> {
  _$ProgressSessionCopyWithImpl(this._self, this._then);

  final ProgressSession _self;
  final $Res Function(ProgressSession) _then;

/// Create a copy of ProgressSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? recipeId = null,Object? currentStep = null,Object? checkedItems = null,Object? startedAt = null,Object? timers = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,checkedItems: null == checkedItems ? _self.checkedItems : checkedItems // ignore: cast_nullable_to_non_nullable
as List<String>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,timers: null == timers ? _self.timers : timers // ignore: cast_nullable_to_non_nullable
as List<SessionTimer>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressSession].
extension ProgressSessionPatterns on ProgressSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressSession value)  $default,){
final _that = this;
switch (_that) {
case _ProgressSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressSession value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String recipeId,  int currentStep,  List<String> checkedItems,  String startedAt,  List<SessionTimer> timers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressSession() when $default != null:
return $default(_that.sessionId,_that.recipeId,_that.currentStep,_that.checkedItems,_that.startedAt,_that.timers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String recipeId,  int currentStep,  List<String> checkedItems,  String startedAt,  List<SessionTimer> timers)  $default,) {final _that = this;
switch (_that) {
case _ProgressSession():
return $default(_that.sessionId,_that.recipeId,_that.currentStep,_that.checkedItems,_that.startedAt,_that.timers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String recipeId,  int currentStep,  List<String> checkedItems,  String startedAt,  List<SessionTimer> timers)?  $default,) {final _that = this;
switch (_that) {
case _ProgressSession() when $default != null:
return $default(_that.sessionId,_that.recipeId,_that.currentStep,_that.checkedItems,_that.startedAt,_that.timers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressSession implements ProgressSession {
  const _ProgressSession({required this.sessionId, required this.recipeId, required this.currentStep, final  List<String> checkedItems = const [], this.startedAt = '', final  List<SessionTimer> timers = const []}): _checkedItems = checkedItems,_timers = timers;
  factory _ProgressSession.fromJson(Map<String, dynamic> json) => _$ProgressSessionFromJson(json);

@override final  String sessionId;
@override final  String recipeId;
@override final  int currentStep;
 final  List<String> _checkedItems;
@override@JsonKey() List<String> get checkedItems {
  if (_checkedItems is EqualUnmodifiableListView) return _checkedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checkedItems);
}

@override@JsonKey() final  String startedAt;
 final  List<SessionTimer> _timers;
@override@JsonKey() List<SessionTimer> get timers {
  if (_timers is EqualUnmodifiableListView) return _timers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timers);
}


/// Create a copy of ProgressSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressSessionCopyWith<_ProgressSession> get copyWith => __$ProgressSessionCopyWithImpl<_ProgressSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&const DeepCollectionEquality().equals(other._checkedItems, _checkedItems)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&const DeepCollectionEquality().equals(other._timers, _timers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,recipeId,currentStep,const DeepCollectionEquality().hash(_checkedItems),startedAt,const DeepCollectionEquality().hash(_timers));

@override
String toString() {
  return 'ProgressSession(sessionId: $sessionId, recipeId: $recipeId, currentStep: $currentStep, checkedItems: $checkedItems, startedAt: $startedAt, timers: $timers)';
}


}

/// @nodoc
abstract mixin class _$ProgressSessionCopyWith<$Res> implements $ProgressSessionCopyWith<$Res> {
  factory _$ProgressSessionCopyWith(_ProgressSession value, $Res Function(_ProgressSession) _then) = __$ProgressSessionCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String recipeId, int currentStep, List<String> checkedItems, String startedAt, List<SessionTimer> timers
});




}
/// @nodoc
class __$ProgressSessionCopyWithImpl<$Res>
    implements _$ProgressSessionCopyWith<$Res> {
  __$ProgressSessionCopyWithImpl(this._self, this._then);

  final _ProgressSession _self;
  final $Res Function(_ProgressSession) _then;

/// Create a copy of ProgressSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? recipeId = null,Object? currentStep = null,Object? checkedItems = null,Object? startedAt = null,Object? timers = null,}) {
  return _then(_ProgressSession(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,checkedItems: null == checkedItems ? _self._checkedItems : checkedItems // ignore: cast_nullable_to_non_nullable
as List<String>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,timers: null == timers ? _self._timers : timers // ignore: cast_nullable_to_non_nullable
as List<SessionTimer>,
  ));
}


}

// dart format on
