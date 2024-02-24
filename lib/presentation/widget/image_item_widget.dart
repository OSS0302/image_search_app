import 'package:flutter/material.dart';

import '../../domain/model/image_items.dart';



class ImageItemWidget extends StatelessWidget {
  final ImageItems imageItems;

  const ImageItemWidget({
    super.key,
    required this.imageItems,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // 코너의 둥근 정도 조절
      child: Image.network(
        imageItems.imageUrl,
        // 이미지 경로
        fit: BoxFit.cover,
      ),
    );
  }
}