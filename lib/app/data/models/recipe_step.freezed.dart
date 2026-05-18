// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeStep {

 int get stepNo; String get title; int get estimatedTimeSec; String get imageUrl; List<String> get description; List<String> get tips; List<ChecklistItem> get checklist; List<DeductionPoint> get deductionPoints; List<StepTimer> get timers; List<CalculatorConfig> get calculators; List<StepImage> get images;
/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeStepCopyWith<RecipeStep> get copyWith => _$RecipeStepCopyWithImpl<RecipeStep>(this as RecipeStep, _$identity);

  /// Serializes this RecipeStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeStep&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.title, title) || other.title == title)&&(identical(other.estimatedTimeSec, estimatedTimeSec) || other.estimatedTimeSec == estimatedTimeSec)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.description, description)&&const DeepCollectionEquality().equals(other.tips, tips)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&const DeepCollectionEquality().equals(other.deductionPoints, deductionPoints)&&const DeepCollectionEquality().equals(other.timers, timers)&&const DeepCollectionEquality().equals(other.calculators, calculators)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stepNo,title,estimatedTimeSec,imageUrl,const DeepCollectionEquality().hash(description),const DeepCollectionEquality().hash(tips),const DeepCollectionEquality().hash(checklist),const DeepCollectionEquality().hash(deductionPoints),const DeepCollectionEquality().hash(timers),const DeepCollectionEquality().hash(calculators),const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'RecipeStep(stepNo: $stepNo, title: $title, estimatedTimeSec: $estimatedTimeSec, imageUrl: $imageUrl, description: $description, tips: $tips, checklist: $checklist, deductionPoints: $deductionPoints, timers: $timers, calculators: $calculators, images: $images)';
}


}

/// @nodoc
abstract mixin class $RecipeStepCopyWith<$Res>  {
  factory $RecipeStepCopyWith(RecipeStep value, $Res Function(RecipeStep) _then) = _$RecipeStepCopyWithImpl;
@useResult
$Res call({
 int stepNo, String title, int estimatedTimeSec, String imageUrl, List<String> description, List<String> tips, List<ChecklistItem> checklist, List<DeductionPoint> deductionPoints, List<StepTimer> timers, List<CalculatorConfig> calculators, List<StepImage> images
});




}
/// @nodoc
class _$RecipeStepCopyWithImpl<$Res>
    implements $RecipeStepCopyWith<$Res> {
  _$RecipeStepCopyWithImpl(this._self, this._then);

  final RecipeStep _self;
  final $Res Function(RecipeStep) _then;

/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNo = null,Object? title = null,Object? estimatedTimeSec = null,Object? imageUrl = null,Object? description = null,Object? tips = null,Object? checklist = null,Object? deductionPoints = null,Object? timers = null,Object? calculators = null,Object? images = null,}) {
  return _then(_self.copyWith(
stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,estimatedTimeSec: null == estimatedTimeSec ? _self.estimatedTimeSec : estimatedTimeSec // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as List<String>,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,deductionPoints: null == deductionPoints ? _self.deductionPoints : deductionPoints // ignore: cast_nullable_to_non_nullable
as List<DeductionPoint>,timers: null == timers ? _self.timers : timers // ignore: cast_nullable_to_non_nullable
as List<StepTimer>,calculators: null == calculators ? _self.calculators : calculators // ignore: cast_nullable_to_non_nullable
as List<CalculatorConfig>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<StepImage>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeStep].
extension RecipeStepPatterns on RecipeStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeStep value)  $default,){
final _that = this;
switch (_that) {
case _RecipeStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeStep value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNo,  String title,  int estimatedTimeSec,  String imageUrl,  List<String> description,  List<String> tips,  List<ChecklistItem> checklist,  List<DeductionPoint> deductionPoints,  List<StepTimer> timers,  List<CalculatorConfig> calculators,  List<StepImage> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
return $default(_that.stepNo,_that.title,_that.estimatedTimeSec,_that.imageUrl,_that.description,_that.tips,_that.checklist,_that.deductionPoints,_that.timers,_that.calculators,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNo,  String title,  int estimatedTimeSec,  String imageUrl,  List<String> description,  List<String> tips,  List<ChecklistItem> checklist,  List<DeductionPoint> deductionPoints,  List<StepTimer> timers,  List<CalculatorConfig> calculators,  List<StepImage> images)  $default,) {final _that = this;
switch (_that) {
case _RecipeStep():
return $default(_that.stepNo,_that.title,_that.estimatedTimeSec,_that.imageUrl,_that.description,_that.tips,_that.checklist,_that.deductionPoints,_that.timers,_that.calculators,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNo,  String title,  int estimatedTimeSec,  String imageUrl,  List<String> description,  List<String> tips,  List<ChecklistItem> checklist,  List<DeductionPoint> deductionPoints,  List<StepTimer> timers,  List<CalculatorConfig> calculators,  List<StepImage> images)?  $default,) {final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
return $default(_that.stepNo,_that.title,_that.estimatedTimeSec,_that.imageUrl,_that.description,_that.tips,_that.checklist,_that.deductionPoints,_that.timers,_that.calculators,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeStep implements RecipeStep {
  const _RecipeStep({required this.stepNo, required this.title, this.estimatedTimeSec = 0, this.imageUrl = '', final  List<String> description = const [], final  List<String> tips = const [], final  List<ChecklistItem> checklist = const [], final  List<DeductionPoint> deductionPoints = const [], final  List<StepTimer> timers = const [], final  List<CalculatorConfig> calculators = const [], final  List<StepImage> images = const []}): _description = description,_tips = tips,_checklist = checklist,_deductionPoints = deductionPoints,_timers = timers,_calculators = calculators,_images = images;
  factory _RecipeStep.fromJson(Map<String, dynamic> json) => _$RecipeStepFromJson(json);

@override final  int stepNo;
@override final  String title;
@override@JsonKey() final  int estimatedTimeSec;
@override@JsonKey() final  String imageUrl;
 final  List<String> _description;
@override@JsonKey() List<String> get description {
  if (_description is EqualUnmodifiableListView) return _description;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_description);
}

 final  List<String> _tips;
@override@JsonKey() List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
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

 final  List<StepImage> _images;
@override@JsonKey() List<StepImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeStepCopyWith<_RecipeStep> get copyWith => __$RecipeStepCopyWithImpl<_RecipeStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeStep&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.title, title) || other.title == title)&&(identical(other.estimatedTimeSec, estimatedTimeSec) || other.estimatedTimeSec == estimatedTimeSec)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._description, _description)&&const DeepCollectionEquality().equals(other._tips, _tips)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&const DeepCollectionEquality().equals(other._deductionPoints, _deductionPoints)&&const DeepCollectionEquality().equals(other._timers, _timers)&&const DeepCollectionEquality().equals(other._calculators, _calculators)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stepNo,title,estimatedTimeSec,imageUrl,const DeepCollectionEquality().hash(_description),const DeepCollectionEquality().hash(_tips),const DeepCollectionEquality().hash(_checklist),const DeepCollectionEquality().hash(_deductionPoints),const DeepCollectionEquality().hash(_timers),const DeepCollectionEquality().hash(_calculators),const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'RecipeStep(stepNo: $stepNo, title: $title, estimatedTimeSec: $estimatedTimeSec, imageUrl: $imageUrl, description: $description, tips: $tips, checklist: $checklist, deductionPoints: $deductionPoints, timers: $timers, calculators: $calculators, images: $images)';
}


}

/// @nodoc
abstract mixin class _$RecipeStepCopyWith<$Res> implements $RecipeStepCopyWith<$Res> {
  factory _$RecipeStepCopyWith(_RecipeStep value, $Res Function(_RecipeStep) _then) = __$RecipeStepCopyWithImpl;
@override @useResult
$Res call({
 int stepNo, String title, int estimatedTimeSec, String imageUrl, List<String> description, List<String> tips, List<ChecklistItem> checklist, List<DeductionPoint> deductionPoints, List<StepTimer> timers, List<CalculatorConfig> calculators, List<StepImage> images
});




}
/// @nodoc
class __$RecipeStepCopyWithImpl<$Res>
    implements _$RecipeStepCopyWith<$Res> {
  __$RecipeStepCopyWithImpl(this._self, this._then);

  final _RecipeStep _self;
  final $Res Function(_RecipeStep) _then;

/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNo = null,Object? title = null,Object? estimatedTimeSec = null,Object? imageUrl = null,Object? description = null,Object? tips = null,Object? checklist = null,Object? deductionPoints = null,Object? timers = null,Object? calculators = null,Object? images = null,}) {
  return _then(_RecipeStep(
stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,estimatedTimeSec: null == estimatedTimeSec ? _self.estimatedTimeSec : estimatedTimeSec // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self._description : description // ignore: cast_nullable_to_non_nullable
as List<String>,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,deductionPoints: null == deductionPoints ? _self._deductionPoints : deductionPoints // ignore: cast_nullable_to_non_nullable
as List<DeductionPoint>,timers: null == timers ? _self._timers : timers // ignore: cast_nullable_to_non_nullable
as List<StepTimer>,calculators: null == calculators ? _self._calculators : calculators // ignore: cast_nullable_to_non_nullable
as List<CalculatorConfig>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<StepImage>,
  ));
}


}

// dart format on
