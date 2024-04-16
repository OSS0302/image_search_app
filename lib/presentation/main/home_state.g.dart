// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeStateImpl _$$HomeStateImplFromJson(Map<String, dynamic> json) =>
    _$HomeStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      imageItem: (json['imageItem'] as List<dynamic>?)
              ?.map((e) => ImageItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'imageItem': instance.imageItem,
    };
