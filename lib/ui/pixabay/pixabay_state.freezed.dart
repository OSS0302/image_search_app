// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pixabay_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PixabayState _$PixabayStateFromJson(Map<String, dynamic> json) {
  return _PixabayState.fromJson(json);
}

/// @nodoc
mixin _$PixabayState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<PixabayItem> get imageItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PixabayStateCopyWith<PixabayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixabayStateCopyWith<$Res> {
  factory $PixabayStateCopyWith(
          PixabayState value, $Res Function(PixabayState) then) =
      _$PixabayStateCopyWithImpl<$Res, PixabayState>;
  @useResult
  $Res call({bool isLoading, List<PixabayItem> imageItems});
}

/// @nodoc
class _$PixabayStateCopyWithImpl<$Res, $Val extends PixabayState>
    implements $PixabayStateCopyWith<$Res> {
  _$PixabayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageItems = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageItems: null == imageItems
          ? _value.imageItems
          : imageItems // ignore: cast_nullable_to_non_nullable
              as List<PixabayItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PixabayStateImplCopyWith<$Res>
    implements $PixabayStateCopyWith<$Res> {
  factory _$$PixabayStateImplCopyWith(
          _$PixabayStateImpl value, $Res Function(_$PixabayStateImpl) then) =
      __$$PixabayStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<PixabayItem> imageItems});
}

/// @nodoc
class __$$PixabayStateImplCopyWithImpl<$Res>
    extends _$PixabayStateCopyWithImpl<$Res, _$PixabayStateImpl>
    implements _$$PixabayStateImplCopyWith<$Res> {
  __$$PixabayStateImplCopyWithImpl(
      _$PixabayStateImpl _value, $Res Function(_$PixabayStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageItems = null,
  }) {
    return _then(_$PixabayStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageItems: null == imageItems
          ? _value._imageItems
          : imageItems // ignore: cast_nullable_to_non_nullable
              as List<PixabayItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PixabayStateImpl with DiagnosticableTreeMixin implements _PixabayState {
  const _$PixabayStateImpl(
      {this.isLoading = false, final List<PixabayItem> imageItems = const []})
      : _imageItems = imageItems;

  factory _$PixabayStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PixabayStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  final List<PixabayItem> _imageItems;
  @override
  @JsonKey()
  List<PixabayItem> get imageItems {
    if (_imageItems is EqualUnmodifiableListView) return _imageItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageItems);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PixabayState(isLoading: $isLoading, imageItems: $imageItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PixabayState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('imageItems', imageItems));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PixabayStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._imageItems, _imageItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_imageItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PixabayStateImplCopyWith<_$PixabayStateImpl> get copyWith =>
      __$$PixabayStateImplCopyWithImpl<_$PixabayStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PixabayStateImplToJson(
      this,
    );
  }
}

abstract class _PixabayState implements PixabayState {
  const factory _PixabayState(
      {final bool isLoading,
      final List<PixabayItem> imageItems}) = _$PixabayStateImpl;

  factory _PixabayState.fromJson(Map<String, dynamic> json) =
      _$PixabayStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  List<PixabayItem> get imageItems;
  @override
  @JsonKey(ignore: true)
  _$$PixabayStateImplCopyWith<_$PixabayStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
