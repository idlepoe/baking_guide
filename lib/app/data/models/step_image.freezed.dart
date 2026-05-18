// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepImage {

 StepImageType get type; String get title; String get imageUrl; String get description;
/// Create a copy of StepImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepImageCopyWith<StepImage> get copyWith => _$StepImageCopyWithImpl<StepImage>(this as StepImage, _$identity);

  /// Serializes this StepImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepImage&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,imageUrl,description);

@override
String toString() {
  return 'StepImage(type: $type, title: $title, imageUrl: $imageUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class $StepImageCopyWith<$Res>  {
  factory $StepImageCopyWith(StepImage value, $Res Function(StepImage) _then) = _$StepImageCopyWithImpl;
@useResult
$Res call({
 StepImageType type, String title, String imageUrl, String description
});




}
/// @nodoc
class _$StepImageCopyWithImpl<$Res>
    implements $StepImageCopyWith<$Res> {
  _$StepImageCopyWithImpl(this._self, this._then);

  final StepImage _self;
  final $Res Function(StepImage) _then;

/// Create a copy of StepImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? imageUrl = null,Object? description = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StepImageType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StepImage].
extension StepImagePatterns on StepImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepImage value)  $default,){
final _that = this;
switch (_that) {
case _StepImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepImage value)?  $default,){
final _that = this;
switch (_that) {
case _StepImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StepImageType type,  String title,  String imageUrl,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepImage() when $default != null:
return $default(_that.type,_that.title,_that.imageUrl,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StepImageType type,  String title,  String imageUrl,  String description)  $default,) {final _that = this;
switch (_that) {
case _StepImage():
return $default(_that.type,_that.title,_that.imageUrl,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StepImageType type,  String title,  String imageUrl,  String description)?  $default,) {final _that = this;
switch (_that) {
case _StepImage() when $default != null:
return $default(_that.type,_that.title,_that.imageUrl,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepImage implements StepImage {
  const _StepImage({required this.type, required this.title, this.imageUrl = '', this.description = ''});
  factory _StepImage.fromJson(Map<String, dynamic> json) => _$StepImageFromJson(json);

@override final  StepImageType type;
@override final  String title;
@override@JsonKey() final  String imageUrl;
@override@JsonKey() final  String description;

/// Create a copy of StepImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepImageCopyWith<_StepImage> get copyWith => __$StepImageCopyWithImpl<_StepImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepImage&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,imageUrl,description);

@override
String toString() {
  return 'StepImage(type: $type, title: $title, imageUrl: $imageUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class _$StepImageCopyWith<$Res> implements $StepImageCopyWith<$Res> {
  factory _$StepImageCopyWith(_StepImage value, $Res Function(_StepImage) _then) = __$StepImageCopyWithImpl;
@override @useResult
$Res call({
 StepImageType type, String title, String imageUrl, String description
});




}
/// @nodoc
class __$StepImageCopyWithImpl<$Res>
    implements _$StepImageCopyWith<$Res> {
  __$StepImageCopyWithImpl(this._self, this._then);

  final _StepImage _self;
  final $Res Function(_StepImage) _then;

/// Create a copy of StepImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? imageUrl = null,Object? description = null,}) {
  return _then(_StepImage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StepImageType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
