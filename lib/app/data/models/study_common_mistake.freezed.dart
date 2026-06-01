// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_common_mistake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyCommonMistake {

 DeductionSeverity get severity; String get title; String get description;
/// Create a copy of StudyCommonMistake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyCommonMistakeCopyWith<StudyCommonMistake> get copyWith => _$StudyCommonMistakeCopyWithImpl<StudyCommonMistake>(this as StudyCommonMistake, _$identity);

  /// Serializes this StudyCommonMistake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyCommonMistake&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,title,description);

@override
String toString() {
  return 'StudyCommonMistake(severity: $severity, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $StudyCommonMistakeCopyWith<$Res>  {
  factory $StudyCommonMistakeCopyWith(StudyCommonMistake value, $Res Function(StudyCommonMistake) _then) = _$StudyCommonMistakeCopyWithImpl;
@useResult
$Res call({
 DeductionSeverity severity, String title, String description
});




}
/// @nodoc
class _$StudyCommonMistakeCopyWithImpl<$Res>
    implements $StudyCommonMistakeCopyWith<$Res> {
  _$StudyCommonMistakeCopyWithImpl(this._self, this._then);

  final StudyCommonMistake _self;
  final $Res Function(StudyCommonMistake) _then;

/// Create a copy of StudyCommonMistake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? severity = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DeductionSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyCommonMistake].
extension StudyCommonMistakePatterns on StudyCommonMistake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyCommonMistake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyCommonMistake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyCommonMistake value)  $default,){
final _that = this;
switch (_that) {
case _StudyCommonMistake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyCommonMistake value)?  $default,){
final _that = this;
switch (_that) {
case _StudyCommonMistake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeductionSeverity severity,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyCommonMistake() when $default != null:
return $default(_that.severity,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeductionSeverity severity,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _StudyCommonMistake():
return $default(_that.severity,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeductionSeverity severity,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _StudyCommonMistake() when $default != null:
return $default(_that.severity,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyCommonMistake implements StudyCommonMistake {
  const _StudyCommonMistake({required this.severity, required this.title, required this.description});
  factory _StudyCommonMistake.fromJson(Map<String, dynamic> json) => _$StudyCommonMistakeFromJson(json);

@override final  DeductionSeverity severity;
@override final  String title;
@override final  String description;

/// Create a copy of StudyCommonMistake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyCommonMistakeCopyWith<_StudyCommonMistake> get copyWith => __$StudyCommonMistakeCopyWithImpl<_StudyCommonMistake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyCommonMistakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyCommonMistake&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,title,description);

@override
String toString() {
  return 'StudyCommonMistake(severity: $severity, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$StudyCommonMistakeCopyWith<$Res> implements $StudyCommonMistakeCopyWith<$Res> {
  factory _$StudyCommonMistakeCopyWith(_StudyCommonMistake value, $Res Function(_StudyCommonMistake) _then) = __$StudyCommonMistakeCopyWithImpl;
@override @useResult
$Res call({
 DeductionSeverity severity, String title, String description
});




}
/// @nodoc
class __$StudyCommonMistakeCopyWithImpl<$Res>
    implements _$StudyCommonMistakeCopyWith<$Res> {
  __$StudyCommonMistakeCopyWithImpl(this._self, this._then);

  final _StudyCommonMistake _self;
  final $Res Function(_StudyCommonMistake) _then;

/// Create a copy of StudyCommonMistake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? severity = null,Object? title = null,Object? description = null,}) {
  return _then(_StudyCommonMistake(
severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DeductionSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
