// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeListItem {

 String get id; String get name; String get category; String get thumbnailUrl; int get difficulty; int get totalTimeSec;
/// Create a copy of RecipeListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeListItemCopyWith<RecipeListItem> get copyWith => _$RecipeListItemCopyWithImpl<RecipeListItem>(this as RecipeListItem, _$identity);

  /// Serializes this RecipeListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalTimeSec, totalTimeSec) || other.totalTimeSec == totalTimeSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,thumbnailUrl,difficulty,totalTimeSec);

@override
String toString() {
  return 'RecipeListItem(id: $id, name: $name, category: $category, thumbnailUrl: $thumbnailUrl, difficulty: $difficulty, totalTimeSec: $totalTimeSec)';
}


}

/// @nodoc
abstract mixin class $RecipeListItemCopyWith<$Res>  {
  factory $RecipeListItemCopyWith(RecipeListItem value, $Res Function(RecipeListItem) _then) = _$RecipeListItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String thumbnailUrl, int difficulty, int totalTimeSec
});




}
/// @nodoc
class _$RecipeListItemCopyWithImpl<$Res>
    implements $RecipeListItemCopyWith<$Res> {
  _$RecipeListItemCopyWithImpl(this._self, this._then);

  final RecipeListItem _self;
  final $Res Function(RecipeListItem) _then;

/// Create a copy of RecipeListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? thumbnailUrl = null,Object? difficulty = null,Object? totalTimeSec = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int,totalTimeSec: null == totalTimeSec ? _self.totalTimeSec : totalTimeSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeListItem].
extension RecipeListItemPatterns on RecipeListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeListItem value)  $default,){
final _that = this;
switch (_that) {
case _RecipeListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeListItem value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String thumbnailUrl,  int difficulty,  int totalTimeSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeListItem() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.thumbnailUrl,_that.difficulty,_that.totalTimeSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String thumbnailUrl,  int difficulty,  int totalTimeSec)  $default,) {final _that = this;
switch (_that) {
case _RecipeListItem():
return $default(_that.id,_that.name,_that.category,_that.thumbnailUrl,_that.difficulty,_that.totalTimeSec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String thumbnailUrl,  int difficulty,  int totalTimeSec)?  $default,) {final _that = this;
switch (_that) {
case _RecipeListItem() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.thumbnailUrl,_that.difficulty,_that.totalTimeSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeListItem implements RecipeListItem {
  const _RecipeListItem({required this.id, required this.name, required this.category, this.thumbnailUrl = '', required this.difficulty, required this.totalTimeSec});
  factory _RecipeListItem.fromJson(Map<String, dynamic> json) => _$RecipeListItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override@JsonKey() final  String thumbnailUrl;
@override final  int difficulty;
@override final  int totalTimeSec;

/// Create a copy of RecipeListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeListItemCopyWith<_RecipeListItem> get copyWith => __$RecipeListItemCopyWithImpl<_RecipeListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalTimeSec, totalTimeSec) || other.totalTimeSec == totalTimeSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,thumbnailUrl,difficulty,totalTimeSec);

@override
String toString() {
  return 'RecipeListItem(id: $id, name: $name, category: $category, thumbnailUrl: $thumbnailUrl, difficulty: $difficulty, totalTimeSec: $totalTimeSec)';
}


}

/// @nodoc
abstract mixin class _$RecipeListItemCopyWith<$Res> implements $RecipeListItemCopyWith<$Res> {
  factory _$RecipeListItemCopyWith(_RecipeListItem value, $Res Function(_RecipeListItem) _then) = __$RecipeListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String thumbnailUrl, int difficulty, int totalTimeSec
});




}
/// @nodoc
class __$RecipeListItemCopyWithImpl<$Res>
    implements _$RecipeListItemCopyWith<$Res> {
  __$RecipeListItemCopyWithImpl(this._self, this._then);

  final _RecipeListItem _self;
  final $Res Function(_RecipeListItem) _then;

/// Create a copy of RecipeListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? thumbnailUrl = null,Object? difficulty = null,Object? totalTimeSec = null,}) {
  return _then(_RecipeListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int,totalTimeSec: null == totalTimeSec ? _self.totalTimeSec : totalTimeSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
