// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageStateImpl _$$ImageStateImplFromJson(Map<String, dynamic> json) =>
    _$ImageStateImpl(
      imageItems: (json['imageItems'] as List<dynamic>?)
              ?.map((e) => ImageItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$ImageStateImplToJson(_$ImageStateImpl instance) =>
    <String, dynamic>{
      'imageItems': instance.imageItems,
      'isLoading': instance.isLoading,
    };
