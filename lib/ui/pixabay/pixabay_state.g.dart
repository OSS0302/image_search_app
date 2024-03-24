// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixabay_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PixabayStateImpl _$$PixabayStateImplFromJson(Map<String, dynamic> json) =>
    _$PixabayStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      imageItems: (json['imageItems'] as List<dynamic>?)
              ?.map((e) => PixabayItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PixabayStateImplToJson(_$PixabayStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'imageItems': instance.imageItems,
    };
