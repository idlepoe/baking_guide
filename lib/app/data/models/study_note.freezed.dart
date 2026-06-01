// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyNote {

 String get id; List<StudyNoteSection> get sections; List<StudyCommonMistake> get commonMistakes; List<StudyNoteImage> get images; List<String> get flow; List<StudyNoteFlashcard> get flashcards;
/// Create a copy of StudyNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyNoteCopyWith<StudyNote> get copyWith => _$StudyNoteCopyWithImpl<StudyNote>(this as StudyNote, _$identity);

  /// Serializes this StudyNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyNote&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.sections, sections)&&const DeepCollectionEquality().equals(other.commonMistakes, commonMistakes)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.flow, flow)&&const DeepCollectionEquality().equals(other.flashcards, flashcards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(sections),const DeepCollectionEquality().hash(commonMistakes),const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(flow),const DeepCollectionEquality().hash(flashcards));

@override
String toString() {
  return 'StudyNote(id: $id, sections: $sections, commonMistakes: $commonMistakes, images: $images, flow: $flow, flashcards: $flashcards)';
}


}

/// @nodoc
abstract mixin class $StudyNoteCopyWith<$Res>  {
  factory $StudyNoteCopyWith(StudyNote value, $Res Function(StudyNote) _then) = _$StudyNoteCopyWithImpl;
@useResult
$Res call({
 String id, List<StudyNoteSection> sections, List<StudyCommonMistake> commonMistakes, List<StudyNoteImage> images, List<String> flow, List<StudyNoteFlashcard> flashcards
});




}
/// @nodoc
class _$StudyNoteCopyWithImpl<$Res>
    implements $StudyNoteCopyWith<$Res> {
  _$StudyNoteCopyWithImpl(this._self, this._then);

  final StudyNote _self;
  final $Res Function(StudyNote) _then;

/// Create a copy of StudyNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sections = null,Object? commonMistakes = null,Object? images = null,Object? flow = null,Object? flashcards = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<StudyNoteSection>,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as List<StudyCommonMistake>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<StudyNoteImage>,flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as List<String>,flashcards: null == flashcards ? _self.flashcards : flashcards // ignore: cast_nullable_to_non_nullable
as List<StudyNoteFlashcard>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyNote].
extension StudyNotePatterns on StudyNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyNote value)  $default,){
final _that = this;
switch (_that) {
case _StudyNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyNote value)?  $default,){
final _that = this;
switch (_that) {
case _StudyNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<StudyNoteSection> sections,  List<StudyCommonMistake> commonMistakes,  List<StudyNoteImage> images,  List<String> flow,  List<StudyNoteFlashcard> flashcards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyNote() when $default != null:
return $default(_that.id,_that.sections,_that.commonMistakes,_that.images,_that.flow,_that.flashcards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<StudyNoteSection> sections,  List<StudyCommonMistake> commonMistakes,  List<StudyNoteImage> images,  List<String> flow,  List<StudyNoteFlashcard> flashcards)  $default,) {final _that = this;
switch (_that) {
case _StudyNote():
return $default(_that.id,_that.sections,_that.commonMistakes,_that.images,_that.flow,_that.flashcards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<StudyNoteSection> sections,  List<StudyCommonMistake> commonMistakes,  List<StudyNoteImage> images,  List<String> flow,  List<StudyNoteFlashcard> flashcards)?  $default,) {final _that = this;
switch (_that) {
case _StudyNote() when $default != null:
return $default(_that.id,_that.sections,_that.commonMistakes,_that.images,_that.flow,_that.flashcards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyNote implements StudyNote {
  const _StudyNote({required this.id, final  List<StudyNoteSection> sections = const [], final  List<StudyCommonMistake> commonMistakes = const [], final  List<StudyNoteImage> images = const [], final  List<String> flow = const [], final  List<StudyNoteFlashcard> flashcards = const []}): _sections = sections,_commonMistakes = commonMistakes,_images = images,_flow = flow,_flashcards = flashcards;
  factory _StudyNote.fromJson(Map<String, dynamic> json) => _$StudyNoteFromJson(json);

@override final  String id;
 final  List<StudyNoteSection> _sections;
@override@JsonKey() List<StudyNoteSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  List<StudyCommonMistake> _commonMistakes;
@override@JsonKey() List<StudyCommonMistake> get commonMistakes {
  if (_commonMistakes is EqualUnmodifiableListView) return _commonMistakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commonMistakes);
}

 final  List<StudyNoteImage> _images;
@override@JsonKey() List<StudyNoteImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<String> _flow;
@override@JsonKey() List<String> get flow {
  if (_flow is EqualUnmodifiableListView) return _flow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flow);
}

 final  List<StudyNoteFlashcard> _flashcards;
@override@JsonKey() List<StudyNoteFlashcard> get flashcards {
  if (_flashcards is EqualUnmodifiableListView) return _flashcards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flashcards);
}


/// Create a copy of StudyNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyNoteCopyWith<_StudyNote> get copyWith => __$StudyNoteCopyWithImpl<_StudyNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyNote&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._sections, _sections)&&const DeepCollectionEquality().equals(other._commonMistakes, _commonMistakes)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._flow, _flow)&&const DeepCollectionEquality().equals(other._flashcards, _flashcards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_commonMistakes),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_flow),const DeepCollectionEquality().hash(_flashcards));

@override
String toString() {
  return 'StudyNote(id: $id, sections: $sections, commonMistakes: $commonMistakes, images: $images, flow: $flow, flashcards: $flashcards)';
}


}

/// @nodoc
abstract mixin class _$StudyNoteCopyWith<$Res> implements $StudyNoteCopyWith<$Res> {
  factory _$StudyNoteCopyWith(_StudyNote value, $Res Function(_StudyNote) _then) = __$StudyNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, List<StudyNoteSection> sections, List<StudyCommonMistake> commonMistakes, List<StudyNoteImage> images, List<String> flow, List<StudyNoteFlashcard> flashcards
});




}
/// @nodoc
class __$StudyNoteCopyWithImpl<$Res>
    implements _$StudyNoteCopyWith<$Res> {
  __$StudyNoteCopyWithImpl(this._self, this._then);

  final _StudyNote _self;
  final $Res Function(_StudyNote) _then;

/// Create a copy of StudyNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sections = null,Object? commonMistakes = null,Object? images = null,Object? flow = null,Object? flashcards = null,}) {
  return _then(_StudyNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<StudyNoteSection>,commonMistakes: null == commonMistakes ? _self._commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as List<StudyCommonMistake>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<StudyNoteImage>,flow: null == flow ? _self._flow : flow // ignore: cast_nullable_to_non_nullable
as List<String>,flashcards: null == flashcards ? _self._flashcards : flashcards // ignore: cast_nullable_to_non_nullable
as List<StudyNoteFlashcard>,
  ));
}


}

// dart format on
