// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_note_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyNoteImage {

 String get title; String get imageUrl;
/// Create a copy of StudyNoteImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyNoteImageCopyWith<StudyNoteImage> get copyWith => _$StudyNoteImageCopyWithImpl<StudyNoteImage>(this as StudyNoteImage, _$identity);

  /// Serializes this StudyNoteImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyNoteImage&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,imageUrl);

@override
String toString() {
  return 'StudyNoteImage(title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $StudyNoteImageCopyWith<$Res>  {
  factory $StudyNoteImageCopyWith(StudyNoteImage value, $Res Function(StudyNoteImage) _then) = _$StudyNoteImageCopyWithImpl;
@useResult
$Res call({
 String title, String imageUrl
});




}
/// @nodoc
class _$StudyNoteImageCopyWithImpl<$Res>
    implements $StudyNoteImageCopyWith<$Res> {
  _$StudyNoteImageCopyWithImpl(this._self, this._then);

  final StudyNoteImage _self;
  final $Res Function(StudyNoteImage) _then;

/// Create a copy of StudyNoteImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyNoteImage].
extension StudyNoteImagePatterns on StudyNoteImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyNoteImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyNoteImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyNoteImage value)  $default,){
final _that = this;
switch (_that) {
case _StudyNoteImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyNoteImage value)?  $default,){
final _that = this;
switch (_that) {
case _StudyNoteImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyNoteImage() when $default != null:
return $default(_that.title,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _StudyNoteImage():
return $default(_that.title,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _StudyNoteImage() when $default != null:
return $default(_that.title,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyNoteImage implements StudyNoteImage {
  const _StudyNoteImage({required this.title, required this.imageUrl});
  factory _StudyNoteImage.fromJson(Map<String, dynamic> json) => _$StudyNoteImageFromJson(json);

@override final  String title;
@override final  String imageUrl;

/// Create a copy of StudyNoteImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyNoteImageCopyWith<_StudyNoteImage> get copyWith => __$StudyNoteImageCopyWithImpl<_StudyNoteImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyNoteImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyNoteImage&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,imageUrl);

@override
String toString() {
  return 'StudyNoteImage(title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$StudyNoteImageCopyWith<$Res> implements $StudyNoteImageCopyWith<$Res> {
  factory _$StudyNoteImageCopyWith(_StudyNoteImage value, $Res Function(_StudyNoteImage) _then) = __$StudyNoteImageCopyWithImpl;
@override @useResult
$Res call({
 String title, String imageUrl
});




}
/// @nodoc
class __$StudyNoteImageCopyWithImpl<$Res>
    implements _$StudyNoteImageCopyWith<$Res> {
  __$StudyNoteImageCopyWithImpl(this._self, this._then);

  final _StudyNoteImage _self;
  final $Res Function(_StudyNoteImage) _then;

/// Create a copy of StudyNoteImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? imageUrl = null,}) {
  return _then(_StudyNoteImage(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
