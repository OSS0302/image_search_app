import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image_model.freezed.dart';

part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  const factory ImageModel({
   required String imageUrl,
   required String tags,
   required int id,

  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, Object?> json) => _$ImageModelFromJson(json);
}