// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyListItem {

 String get id;
/// Create a copy of StudyListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyListItemCopyWith<StudyListItem> get copyWith => _$StudyListItemCopyWithImpl<StudyListItem>(this as StudyListItem, _$identity);

  /// Serializes this StudyListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyListItem&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'StudyListItem(id: $id)';
}


}

/// @nodoc
abstract mixin class $StudyListItemCopyWith<$Res>  {
  factory $StudyListItemCopyWith(StudyListItem value, $Res Function(StudyListItem) _then) = _$StudyListItemCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$StudyListItemCopyWithImpl<$Res>
    implements $StudyListItemCopyWith<$Res> {
  _$StudyListItemCopyWithImpl(this._self, this._then);

  final StudyListItem _self;
  final $Res Function(StudyListItem) _then;

/// Create a copy of StudyListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyListItem].
extension StudyListItemPatterns on StudyListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyListItem value)  $default,){
final _that = this;
switch (_that) {
case _StudyListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyListItem value)?  $default,){
final _that = this;
switch (_that) {
case _StudyListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyListItem() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _StudyListItem():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _StudyListItem() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyListItem implements StudyListItem {
  const _StudyListItem({required this.id});
  factory _StudyListItem.fromJson(Map<String, dynamic> json) => _$StudyListItemFromJson(json);

@override final  String id;

/// Create a copy of StudyListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyListItemCopyWith<_StudyListItem> get copyWith => __$StudyListItemCopyWithImpl<_StudyListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyListItem&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'StudyListItem(id: $id)';
}


}

/// @nodoc
abstract mixin class _$StudyListItemCopyWith<$Res> implements $StudyListItemCopyWith<$Res> {
  factory _$StudyListItemCopyWith(_StudyListItem value, $Res Function(_StudyListItem) _then) = __$StudyListItemCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$StudyListItemCopyWithImpl<$Res>
    implements _$StudyListItemCopyWith<$Res> {
  __$StudyListItemCopyWithImpl(this._self, this._then);

  final _StudyListItem _self;
  final $Res Function(_StudyListItem) _then;

/// Create a copy of StudyListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_StudyListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
