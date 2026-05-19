// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_point_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyPointGroup {

 String get title; String get imageUrl; List<String> get items;
/// Create a copy of KeyPointGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyPointGroupCopyWith<KeyPointGroup> get copyWith => _$KeyPointGroupCopyWithImpl<KeyPointGroup>(this as KeyPointGroup, _$identity);

  /// Serializes this KeyPointGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyPointGroup&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,imageUrl,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'KeyPointGroup(title: $title, imageUrl: $imageUrl, items: $items)';
}


}

/// @nodoc
abstract mixin class $KeyPointGroupCopyWith<$Res>  {
  factory $KeyPointGroupCopyWith(KeyPointGroup value, $Res Function(KeyPointGroup) _then) = _$KeyPointGroupCopyWithImpl;
@useResult
$Res call({
 String title, String imageUrl, List<String> items
});




}
/// @nodoc
class _$KeyPointGroupCopyWithImpl<$Res>
    implements $KeyPointGroupCopyWith<$Res> {
  _$KeyPointGroupCopyWithImpl(this._self, this._then);

  final KeyPointGroup _self;
  final $Res Function(KeyPointGroup) _then;

/// Create a copy of KeyPointGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? imageUrl = null,Object? items = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyPointGroup].
extension KeyPointGroupPatterns on KeyPointGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyPointGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyPointGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyPointGroup value)  $default,){
final _that = this;
switch (_that) {
case _KeyPointGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyPointGroup value)?  $default,){
final _that = this;
switch (_that) {
case _KeyPointGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String imageUrl,  List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyPointGroup() when $default != null:
return $default(_that.title,_that.imageUrl,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String imageUrl,  List<String> items)  $default,) {final _that = this;
switch (_that) {
case _KeyPointGroup():
return $default(_that.title,_that.imageUrl,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String imageUrl,  List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _KeyPointGroup() when $default != null:
return $default(_that.title,_that.imageUrl,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KeyPointGroup implements KeyPointGroup {
  const _KeyPointGroup({required this.title, this.imageUrl = '', final  List<String> items = const []}): _items = items;
  factory _KeyPointGroup.fromJson(Map<String, dynamic> json) => _$KeyPointGroupFromJson(json);

@override final  String title;
@override@JsonKey() final  String imageUrl;
 final  List<String> _items;
@override@JsonKey() List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of KeyPointGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyPointGroupCopyWith<_KeyPointGroup> get copyWith => __$KeyPointGroupCopyWithImpl<_KeyPointGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeyPointGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyPointGroup&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,imageUrl,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'KeyPointGroup(title: $title, imageUrl: $imageUrl, items: $items)';
}


}

/// @nodoc
abstract mixin class _$KeyPointGroupCopyWith<$Res> implements $KeyPointGroupCopyWith<$Res> {
  factory _$KeyPointGroupCopyWith(_KeyPointGroup value, $Res Function(_KeyPointGroup) _then) = __$KeyPointGroupCopyWithImpl;
@override @useResult
$Res call({
 String title, String imageUrl, List<String> items
});




}
/// @nodoc
class __$KeyPointGroupCopyWithImpl<$Res>
    implements _$KeyPointGroupCopyWith<$Res> {
  __$KeyPointGroupCopyWithImpl(this._self, this._then);

  final _KeyPointGroup _self;
  final $Res Function(_KeyPointGroup) _then;

/// Create a copy of KeyPointGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? imageUrl = null,Object? items = null,}) {
  return _then(_KeyPointGroup(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
