// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Step {

 int get stepNo; String get title; int get estimatedTimeSec; List<String> get description; List<StepImage> get images; List<ChecklistItem> get checklist; List<DeductionPoint> get deductionPoints; List<StepTimer> get timers; List<CalculatorConfig> get calculators;
/// Create a copy of Step
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepCopyWith<Step> get copyWith => _$StepCopyWithImpl<Step>(this as Step, _$identity);

  /// Serializes this Step to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Step&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.title, title) || other.title == title)&&(identical(other.estimatedTimeSec, estimatedTimeSec) || other.estimatedTimeSec == estimatedTimeSec)&&const DeepCollectionEquality().equals(other.description, description)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&const DeepCollectionEquality().equals(other.deductionPoints, deductionPoints)&&const DeepCollectionEquality().equals(other.timers, timers)&&const DeepCollectionEquality().equals(other.calculators, calculators));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stepNo,title,estimatedTimeSec,const DeepCollectionEquality().hash(description),const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(checklist),const DeepCollectionEquality().hash(deductionPoints),const DeepCollectionEquality().hash(timers),const DeepCollectionEquality().hash(calculators));

@override
String toString() {
  return 'Step(stepNo: $stepNo, title: $title, estimatedTimeSec: $estimatedTimeSec, description: $description, images: $images, checklist: $checklist, deductionPoints: $deductionPoints, timers: $timers, calculators: $calculators)';
}


}

/// @nodoc
abstract mixin class $StepCopyWith<$Res>  {
  factory $StepCopyWith(Step value, $Res Function(Step) _then) = _$StepCopyWithImpl;
@useResult
$Res call({
 int stepNo, String title, int estimatedTimeSec, List<String> description, List<StepImage> images, List<ChecklistItem> checklist, List<DeductionPoint> deductionPoints, List<StepTimer> timers, List<CalculatorConfig> calculators
});




}
/// @nodoc
class _$StepCopyWithImpl<$Res>
    implements $StepCopyWith<$Res> {
  _$StepCopyWithImpl(this._self, this._then);

  final Step _self;
  final $Res Function(Step) _then;

/// Create a copy of Step
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNo = null,Object? title = null,Object? estimatedTimeSec = null,Object? description = null,Object? images = null,Object? checklist = null,Object? deductionPoints = null,Object? timers = null,Object? calculators = null,}) {
  return _then(_self.copyWith(
stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,estimatedTimeSec: null == estimatedTimeSec ? _self.estimatedTimeSec : estimatedTimeSec // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as List<String>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<StepImage>,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,deductionPoints: null == deductionPoints ? _self.deductionPoints : deductionPoints // ignore: cast_nullable_to_non_nullable
as List<DeductionPoint>,timers: null == timers ? _self.timers : timers // ignore: cast_nullable_to_non_nullable
as List<StepTimer>,calculators: null == calculators ? _self.calculators : calculators // ignore: cast_nullable_to_non_nullable
as List<CalculatorConfig>,
  ));
}

}


/// Adds pattern-matching-related methods to [Step].
extension StepPatterns on Step {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Step value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Step() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Step value)  $default,){
final _that = this;
switch (_that) {
case _Step():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Step value)?  $default,){
final _that = this;
switch (_that) {
case _Step() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNo,  String title,  int estimatedTimeSec,  List<String> description,  List<StepImage> images,  List<ChecklistItem> checklist,  List<DeductionPoint> deductionPoints,  List<StepTimer> timers,  List<CalculatorConfig> calculators)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Step() when $default != null:
return $default(_that.stepNo,_that.title,_that.estimatedTimeSec,_that.description,_that.images,_that.checklist,_that.deductionPoints,_that.timers,_that.calculators);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNo,  String title,  int estimatedTimeSec,  List<String> description,  List<StepImage> images,  List<ChecklistItem> checklist,  List<DeductionPoint> deductionPoints,  List<StepTimer> timers,  List<CalculatorConfig> calculators)  $default,) {final _that = this;
switch (_that) {
case _Step():
return $default(_that.stepNo,_that.title,_that.estimatedTimeSec,_that.description,_that.images,_that.checklist,_that.deductionPoints,_that.timers,_that.calculators);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNo,  String title,  int estimatedTimeSec,  List<String> description,  List<StepImage> images,  List<ChecklistItem> checklist,  List<DeductionPoint> deductionPoints,  List<StepTimer> timers,  List<CalculatorConfig> calculators)?  $default,) {final _that = this;
switch (_that) {
case _Step() when $default != null:
return $default(_that.stepNo,_that.title,_that.estimatedTimeSec,_that.description,_that.images,_that.checklist,_that.deductionPoints,_that.timers,_that.calculators);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Step implements Step {
  const _Step({required this.stepNo, required this.title, required this.estimatedTimeSec, final  List<String> description = const [], final  List<StepImage> images = const [], final  List<ChecklistItem> checklist = const [], final  List<DeductionPoint> deductionPoints = const [], final  List<StepTimer> timers = const [], final  List<CalculatorConfig> calculators = const []}): _description = description,_images = images,_checklist = checklist,_deductionPoints = deductionPoints,_timers = timers,_calculators = calculators;
  factory _Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

@override final  int stepNo;
@override final  String title;
@override final  int estimatedTimeSec;
 final  List<String> _description;
@override@JsonKey() List<String> get description {
  if (_description is EqualUnmodifiableListView) return _description;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_description);
}

 final  List<StepImage> _images;
@override@JsonKey() List<StepImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<ChecklistItem> _checklist;
@override@JsonKey() List<ChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

 final  List<DeductionPoint> _deductionPoints;
@override@JsonKey() List<DeductionPoint> get deductionPoints {
  if (_deductionPoints is EqualUnmodifiableListView) return _deductionPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deductionPoints);
}

 final  List<StepTimer> _timers;
@override@JsonKey() List<StepTimer> get timers {
  if (_timers is EqualUnmodifiableListView) return _timers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timers);
}

 final  List<CalculatorConfig> _calculators;
@override@JsonKey() List<CalculatorConfig> get calculators {
  if (_calculators is EqualUnmodifiableListView) return _calculators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_calculators);
}


/// Create a copy of Step
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepCopyWith<_Step> get copyWith => __$StepCopyWithImpl<_Step>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Step&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.title, title) || other.title == title)&&(identical(other.estimatedTimeSec, estimatedTimeSec) || other.estimatedTimeSec == estimatedTimeSec)&&const DeepCollectionEquality().equals(other._description, _description)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&const DeepCollectionEquality().equals(other._deductionPoints, _deductionPoints)&&const DeepCollectionEquality().equals(other._timers, _timers)&&const DeepCollectionEquality().equals(other._calculators, _calculators));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stepNo,title,estimatedTimeSec,const DeepCollectionEquality().hash(_description),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_checklist),const DeepCollectionEquality().hash(_deductionPoints),const DeepCollectionEquality().hash(_timers),const DeepCollectionEquality().hash(_calculators));

@override
String toString() {
  return 'Step(stepNo: $stepNo, title: $title, estimatedTimeSec: $estimatedTimeSec, description: $description, images: $images, checklist: $checklist, deductionPoints: $deductionPoints, timers: $timers, calculators: $calculators)';
}


}

/// @nodoc
abstract mixin class _$StepCopyWith<$Res> implements $StepCopyWith<$Res> {
  factory _$StepCopyWith(_Step value, $Res Function(_Step) _then) = __$StepCopyWithImpl;
@override @useResult
$Res call({
 int stepNo, String title, int estimatedTimeSec, List<String> description, List<StepImage> images, List<ChecklistItem> checklist, List<DeductionPoint> deductionPoints, List<StepTimer> timers, List<CalculatorConfig> calculators
});




}
/// @nodoc
class __$StepCopyWithImpl<$Res>
    implements _$StepCopyWith<$Res> {
  __$StepCopyWithImpl(this._self, this._then);

  final _Step _self;
  final $Res Function(_Step) _then;

/// Create a copy of Step
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNo = null,Object? title = null,Object? estimatedTimeSec = null,Object? description = null,Object? images = null,Object? checklist = null,Object? deductionPoints = null,Object? timers = null,Object? calculators = null,}) {
  return _then(_Step(
stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,estimatedTimeSec: null == estimatedTimeSec ? _self.estimatedTimeSec : estimatedTimeSec // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self._description : description // ignore: cast_nullable_to_non_nullable
as List<String>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<StepImage>,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,deductionPoints: null == deductionPoints ? _self._deductionPoints : deductionPoints // ignore: cast_nullable_to_non_nullable
as List<DeductionPoint>,timers: null == timers ? _self._timers : timers // ignore: cast_nullable_to_non_nullable
as List<StepTimer>,calculators: null == calculators ? _self._calculators : calculators // ignore: cast_nullable_to_non_nullable
as List<CalculatorConfig>,
  ));
}


}

// dart format on
