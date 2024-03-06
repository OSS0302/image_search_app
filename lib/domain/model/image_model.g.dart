// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageModelImpl _$$ImageModelImplFromJson(Map<String, dynamic> json) =>
    _$ImageModelImpl(
      imageUrl: json['imageUrl'] as String,
      tags: json['tags'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$ImageModelImplToJson(_$ImageModelImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'id': instance.id,
    };
