// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageItems _$ImageItemsFromJson(Map<String, dynamic> json) {
  return _ImageItems.fromJson(json);
}

/// @nodoc
mixin _$ImageItems {
  String get imageUrl => throw _privateConstructorUsedError;
  String get tags => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageItemsCopyWith<ImageItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageItemsCopyWith<$Res> {
  factory $ImageItemsCopyWith(
          ImageItems value, $Res Function(ImageItems) then) =
      _$ImageItemsCopyWithImpl<$Res, ImageItems>;
  @useResult
  $Res call({String imageUrl, String tags, int id});
}

/// @nodoc
class _$ImageItemsCopyWithImpl<$Res, $Val extends ImageItems>
    implements $ImageItemsCopyWith<$Res> {
  _$ImageItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? tags = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageItemsImplCopyWith<$Res>
    implements $ImageItemsCopyWith<$Res> {
  factory _$$ImageItemsImplCopyWith(
          _$ImageItemsImpl value, $Res Function(_$ImageItemsImpl) then) =
      __$$ImageItemsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String imageUrl, String tags, int id});
}

/// @nodoc
class __$$ImageItemsImplCopyWithImpl<$Res>
    extends _$ImageItemsCopyWithImpl<$Res, _$ImageItemsImpl>
    implements _$$ImageItemsImplCopyWith<$Res> {
  __$$ImageItemsImplCopyWithImpl(
      _$ImageItemsImpl _value, $Res Function(_$ImageItemsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? tags = null,
    Object? id = null,
  }) {
    return _then(_$ImageItemsImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageItemsImpl with DiagnosticableTreeMixin implements _ImageItems {
  const _$ImageItemsImpl(
      {required this.imageUrl, required this.tags, required this.id});

  factory _$ImageItemsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageItemsImplFromJson(json);

  @override
  final String imageUrl;
  @override
  final String tags;
  @override
  final int id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageItems(imageUrl: $imageUrl, tags: $tags, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageItems'))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageItemsImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, tags, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageItemsImplCopyWith<_$ImageItemsImpl> get copyWith =>
      __$$ImageItemsImplCopyWithImpl<_$ImageItemsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageItemsImplToJson(
      this,
    );
  }
}

abstract class _ImageItems implements ImageItems {
  const factory _ImageItems(
      {required final String imageUrl,
      required final String tags,
      required final int id}) = _$ImageItemsImpl;

  factory _ImageItems.fromJson(Map<String, dynamic> json) =
      _$ImageItemsImpl.fromJson;

  @override
  String get imageUrl;
  @override
  String get tags;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$ImageItemsImplCopyWith<_$ImageItemsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
