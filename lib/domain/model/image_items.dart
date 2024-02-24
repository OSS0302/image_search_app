import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image_items.freezed.dart';

part 'image_items.g.dart';

@freezed
class ImageItems with _$ImageItems {
  const factory ImageItems({
    required String imageUrl,
    required String tags,
    required int id,


  }) = _ImageItems;

  factory ImageItems.fromJson(Map<String, Object?> json) => _$ImageItemsFromJson(json);
}