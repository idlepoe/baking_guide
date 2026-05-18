// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeSummary {

 int get examTimeSec; MixingMethod get mixingMethod; OvenSetting get oven; List<KeyPointGroup> get keyPoints;
/// Create a copy of RecipeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeSummaryCopyWith<RecipeSummary> get copyWith => _$RecipeSummaryCopyWithImpl<RecipeSummary>(this as RecipeSummary, _$identity);

  /// Serializes this RecipeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeSummary&&(identical(other.examTimeSec, examTimeSec) || other.examTimeSec == examTimeSec)&&(identical(other.mixingMethod, mixingMethod) || other.mixingMethod == mixingMethod)&&(identical(other.oven, oven) || other.oven == oven)&&const DeepCollectionEquality().equals(other.keyPoints, keyPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,examTimeSec,mixingMethod,oven,const DeepCollectionEquality().hash(keyPoints));

@override
String toString() {
  return 'RecipeSummary(examTimeSec: $examTimeSec, mixingMethod: $mixingMethod, oven: $oven, keyPoints: $keyPoints)';
}


}

/// @nodoc
abstract mixin class $RecipeSummaryCopyWith<$Res>  {
  factory $RecipeSummaryCopyWith(RecipeSummary value, $Res Function(RecipeSummary) _then) = _$RecipeSummaryCopyWithImpl;
@useResult
$Res call({
 int examTimeSec, MixingMethod mixingMethod, OvenSetting oven, List<KeyPointGroup> keyPoints
});


$OvenSettingCopyWith<$Res> get oven;

}
/// @nodoc
class _$RecipeSummaryCopyWithImpl<$Res>
    implements $RecipeSummaryCopyWith<$Res> {
  _$RecipeSummaryCopyWithImpl(this._self, this._then);

  final RecipeSummary _self;
  final $Res Function(RecipeSummary) _then;

/// Create a copy of RecipeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? examTimeSec = null,Object? mixingMethod = null,Object? oven = null,Object? keyPoints = null,}) {
  return _then(_self.copyWith(
examTimeSec: null == examTimeSec ? _self.examTimeSec : examTimeSec // ignore: cast_nullable_to_non_nullable
as int,mixingMethod: null == mixingMethod ? _self.mixingMethod : mixingMethod // ignore: cast_nullable_to_non_nullable
as MixingMethod,oven: null == oven ? _self.oven : oven // ignore: cast_nullable_to_non_nullable
as OvenSetting,keyPoints: null == keyPoints ? _self.keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as List<KeyPointGroup>,
  ));
}
/// Create a copy of RecipeSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OvenSettingCopyWith<$Res> get oven {
  
  return $OvenSettingCopyWith<$Res>(_self.oven, (value) {
    return _then(_self.copyWith(oven: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecipeSummary].
extension RecipeSummaryPatterns on RecipeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeSummary value)  $default,){
final _that = this;
switch (_that) {
case _RecipeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int examTimeSec,  MixingMethod mixingMethod,  OvenSetting oven,  List<KeyPointGroup> keyPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeSummary() when $default != null:
return $default(_that.examTimeSec,_that.mixingMethod,_that.oven,_that.keyPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int examTimeSec,  MixingMethod mixingMethod,  OvenSetting oven,  List<KeyPointGroup> keyPoints)  $default,) {final _that = this;
switch (_that) {
case _RecipeSummary():
return $default(_that.examTimeSec,_that.mixingMethod,_that.oven,_that.keyPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int examTimeSec,  MixingMethod mixingMethod,  OvenSetting oven,  List<KeyPointGroup> keyPoints)?  $default,) {final _that = this;
switch (_that) {
case _RecipeSummary() when $default != null:
return $default(_that.examTimeSec,_that.mixingMethod,_that.oven,_that.keyPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeSummary implements RecipeSummary {
  const _RecipeSummary({required this.examTimeSec, required this.mixingMethod, required this.oven, final  List<KeyPointGroup> keyPoints = const []}): _keyPoints = keyPoints;
  factory _RecipeSummary.fromJson(Map<String, dynamic> json) => _$RecipeSummaryFromJson(json);

@override final  int examTimeSec;
@override final  MixingMethod mixingMethod;
@override final  OvenSetting oven;
 final  List<KeyPointGroup> _keyPoints;
@override@JsonKey() List<KeyPointGroup> get keyPoints {
  if (_keyPoints is EqualUnmodifiableListView) return _keyPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keyPoints);
}


/// Create a copy of RecipeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeSummaryCopyWith<_RecipeSummary> get copyWith => __$RecipeSummaryCopyWithImpl<_RecipeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeSummary&&(identical(other.examTimeSec, examTimeSec) || other.examTimeSec == examTimeSec)&&(identical(other.mixingMethod, mixingMethod) || other.mixingMethod == mixingMethod)&&(identical(other.oven, oven) || other.oven == oven)&&const DeepCollectionEquality().equals(other._keyPoints, _keyPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,examTimeSec,mixingMethod,oven,const DeepCollectionEquality().hash(_keyPoints));

@override
String toString() {
  return 'RecipeSummary(examTimeSec: $examTimeSec, mixingMethod: $mixingMethod, oven: $oven, keyPoints: $keyPoints)';
}


}

/// @nodoc
abstract mixin class _$RecipeSummaryCopyWith<$Res> implements $RecipeSummaryCopyWith<$Res> {
  factory _$RecipeSummaryCopyWith(_RecipeSummary value, $Res Function(_RecipeSummary) _then) = __$RecipeSummaryCopyWithImpl;
@override @useResult
$Res call({
 int examTimeSec, MixingMethod mixingMethod, OvenSetting oven, List<KeyPointGroup> keyPoints
});


@override $OvenSettingCopyWith<$Res> get oven;

}
/// @nodoc
class __$RecipeSummaryCopyWithImpl<$Res>
    implements _$RecipeSummaryCopyWith<$Res> {
  __$RecipeSummaryCopyWithImpl(this._self, this._then);

  final _RecipeSummary _self;
  final $Res Function(_RecipeSummary) _then;

/// Create a copy of RecipeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? examTimeSec = null,Object? mixingMethod = null,Object? oven = null,Object? keyPoints = null,}) {
  return _then(_RecipeSummary(
examTimeSec: null == examTimeSec ? _self.examTimeSec : examTimeSec // ignore: cast_nullable_to_non_nullable
as int,mixingMethod: null == mixingMethod ? _self.mixingMethod : mixingMethod // ignore: cast_nullable_to_non_nullable
as MixingMethod,oven: null == oven ? _self.oven : oven // ignore: cast_nullable_to_non_nullable
as OvenSetting,keyPoints: null == keyPoints ? _self._keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as List<KeyPointGroup>,
  ));
}

/// Create a copy of RecipeSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OvenSettingCopyWith<$Res> get oven {
  
  return $OvenSettingCopyWith<$Res>(_self.oven, (value) {
    return _then(_self.copyWith(oven: value));
  });
}
}

// dart format on
