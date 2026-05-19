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

 String get sessionId; String get recipeId; ProgressSessionStatus get status;@IsoDateTimeConverter() DateTime get startedAt;@IsoDateTimeConverter() DateTime get updatedAt;@IsoDateTimeConverter() DateTime? get completedAt; int get currentStepNo; List<int> get completedSteps; List<StepProgress> get steps;
/// Create a copy of ProgressSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressSessionCopyWith<ProgressSession> get copyWith => _$ProgressSessionCopyWithImpl<ProgressSession>(this as ProgressSession, _$identity);

  /// Serializes this ProgressSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.currentStepNo, currentStepNo) || other.currentStepNo == currentStepNo)&&const DeepCollectionEquality().equals(other.completedSteps, completedSteps)&&const DeepCollectionEquality().equals(other.steps, steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,recipeId,status,startedAt,updatedAt,completedAt,currentStepNo,const DeepCollectionEquality().hash(completedSteps),const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'ProgressSession(sessionId: $sessionId, recipeId: $recipeId, status: $status, startedAt: $startedAt, updatedAt: $updatedAt, completedAt: $completedAt, currentStepNo: $currentStepNo, completedSteps: $completedSteps, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $ProgressSessionCopyWith<$Res>  {
  factory $ProgressSessionCopyWith(ProgressSession value, $Res Function(ProgressSession) _then) = _$ProgressSessionCopyWithImpl;
@useResult
$Res call({
 String sessionId, String recipeId, ProgressSessionStatus status,@IsoDateTimeConverter() DateTime startedAt,@IsoDateTimeConverter() DateTime updatedAt,@IsoDateTimeConverter() DateTime? completedAt, int currentStepNo, List<int> completedSteps, List<StepProgress> steps
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
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? recipeId = null,Object? status = null,Object? startedAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? currentStepNo = null,Object? completedSteps = null,Object? steps = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProgressSessionStatus,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentStepNo: null == currentStepNo ? _self.currentStepNo : currentStepNo // ignore: cast_nullable_to_non_nullable
as int,completedSteps: null == completedSteps ? _self.completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as List<int>,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<StepProgress>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String recipeId,  ProgressSessionStatus status, @IsoDateTimeConverter()  DateTime startedAt, @IsoDateTimeConverter()  DateTime updatedAt, @IsoDateTimeConverter()  DateTime? completedAt,  int currentStepNo,  List<int> completedSteps,  List<StepProgress> steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressSession() when $default != null:
return $default(_that.sessionId,_that.recipeId,_that.status,_that.startedAt,_that.updatedAt,_that.completedAt,_that.currentStepNo,_that.completedSteps,_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String recipeId,  ProgressSessionStatus status, @IsoDateTimeConverter()  DateTime startedAt, @IsoDateTimeConverter()  DateTime updatedAt, @IsoDateTimeConverter()  DateTime? completedAt,  int currentStepNo,  List<int> completedSteps,  List<StepProgress> steps)  $default,) {final _that = this;
switch (_that) {
case _ProgressSession():
return $default(_that.sessionId,_that.recipeId,_that.status,_that.startedAt,_that.updatedAt,_that.completedAt,_that.currentStepNo,_that.completedSteps,_that.steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String recipeId,  ProgressSessionStatus status, @IsoDateTimeConverter()  DateTime startedAt, @IsoDateTimeConverter()  DateTime updatedAt, @IsoDateTimeConverter()  DateTime? completedAt,  int currentStepNo,  List<int> completedSteps,  List<StepProgress> steps)?  $default,) {final _that = this;
switch (_that) {
case _ProgressSession() when $default != null:
return $default(_that.sessionId,_that.recipeId,_that.status,_that.startedAt,_that.updatedAt,_that.completedAt,_that.currentStepNo,_that.completedSteps,_that.steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressSession implements ProgressSession {
  const _ProgressSession({required this.sessionId, required this.recipeId, required this.status, @IsoDateTimeConverter() required this.startedAt, @IsoDateTimeConverter() required this.updatedAt, @IsoDateTimeConverter() this.completedAt, required this.currentStepNo, final  List<int> completedSteps = const [], final  List<StepProgress> steps = const []}): _completedSteps = completedSteps,_steps = steps;
  factory _ProgressSession.fromJson(Map<String, dynamic> json) => _$ProgressSessionFromJson(json);

@override final  String sessionId;
@override final  String recipeId;
@override final  ProgressSessionStatus status;
@override@IsoDateTimeConverter() final  DateTime startedAt;
@override@IsoDateTimeConverter() final  DateTime updatedAt;
@override@IsoDateTimeConverter() final  DateTime? completedAt;
@override final  int currentStepNo;
 final  List<int> _completedSteps;
@override@JsonKey() List<int> get completedSteps {
  if (_completedSteps is EqualUnmodifiableListView) return _completedSteps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedSteps);
}

 final  List<StepProgress> _steps;
@override@JsonKey() List<StepProgress> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.currentStepNo, currentStepNo) || other.currentStepNo == currentStepNo)&&const DeepCollectionEquality().equals(other._completedSteps, _completedSteps)&&const DeepCollectionEquality().equals(other._steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,recipeId,status,startedAt,updatedAt,completedAt,currentStepNo,const DeepCollectionEquality().hash(_completedSteps),const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'ProgressSession(sessionId: $sessionId, recipeId: $recipeId, status: $status, startedAt: $startedAt, updatedAt: $updatedAt, completedAt: $completedAt, currentStepNo: $currentStepNo, completedSteps: $completedSteps, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$ProgressSessionCopyWith<$Res> implements $ProgressSessionCopyWith<$Res> {
  factory _$ProgressSessionCopyWith(_ProgressSession value, $Res Function(_ProgressSession) _then) = __$ProgressSessionCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String recipeId, ProgressSessionStatus status,@IsoDateTimeConverter() DateTime startedAt,@IsoDateTimeConverter() DateTime updatedAt,@IsoDateTimeConverter() DateTime? completedAt, int currentStepNo, List<int> completedSteps, List<StepProgress> steps
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
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? recipeId = null,Object? status = null,Object? startedAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? currentStepNo = null,Object? completedSteps = null,Object? steps = null,}) {
  return _then(_ProgressSession(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProgressSessionStatus,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentStepNo: null == currentStepNo ? _self.currentStepNo : currentStepNo // ignore: cast_nullable_to_non_nullable
as int,completedSteps: null == completedSteps ? _self._completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as List<int>,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<StepProgress>,
  ));
}


}

// dart format on
