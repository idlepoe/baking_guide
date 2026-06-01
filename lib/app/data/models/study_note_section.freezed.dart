// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_note_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyNoteSection {

 String get title; List<String> get items;
/// Create a copy of StudyNoteSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyNoteSectionCopyWith<StudyNoteSection> get copyWith => _$StudyNoteSectionCopyWithImpl<StudyNoteSection>(this as StudyNoteSection, _$identity);

  /// Serializes this StudyNoteSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyNoteSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'StudyNoteSection(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class $StudyNoteSectionCopyWith<$Res>  {
  factory $StudyNoteSectionCopyWith(StudyNoteSection value, $Res Function(StudyNoteSection) _then) = _$StudyNoteSectionCopyWithImpl;
@useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class _$StudyNoteSectionCopyWithImpl<$Res>
    implements $StudyNoteSectionCopyWith<$Res> {
  _$StudyNoteSectionCopyWithImpl(this._self, this._then);

  final StudyNoteSection _self;
  final $Res Function(StudyNoteSection) _then;

/// Create a copy of StudyNoteSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? items = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyNoteSection].
extension StudyNoteSectionPatterns on StudyNoteSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyNoteSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyNoteSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyNoteSection value)  $default,){
final _that = this;
switch (_that) {
case _StudyNoteSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyNoteSection value)?  $default,){
final _that = this;
switch (_that) {
case _StudyNoteSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyNoteSection() when $default != null:
return $default(_that.title,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> items)  $default,) {final _that = this;
switch (_that) {
case _StudyNoteSection():
return $default(_that.title,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _StudyNoteSection() when $default != null:
return $default(_that.title,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyNoteSection implements StudyNoteSection {
  const _StudyNoteSection({required this.title, final  List<String> items = const []}): _items = items;
  factory _StudyNoteSection.fromJson(Map<String, dynamic> json) => _$StudyNoteSectionFromJson(json);

@override final  String title;
 final  List<String> _items;
@override@JsonKey() List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of StudyNoteSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyNoteSectionCopyWith<_StudyNoteSection> get copyWith => __$StudyNoteSectionCopyWithImpl<_StudyNoteSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyNoteSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyNoteSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'StudyNoteSection(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class _$StudyNoteSectionCopyWith<$Res> implements $StudyNoteSectionCopyWith<$Res> {
  factory _$StudyNoteSectionCopyWith(_StudyNoteSection value, $Res Function(_StudyNoteSection) _then) = __$StudyNoteSectionCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class __$StudyNoteSectionCopyWithImpl<$Res>
    implements _$StudyNoteSectionCopyWith<$Res> {
  __$StudyNoteSectionCopyWithImpl(this._self, this._then);

  final _StudyNoteSection _self;
  final $Res Function(_StudyNoteSection) _then;

/// Create a copy of StudyNoteSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? items = null,}) {
  return _then(_StudyNoteSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
