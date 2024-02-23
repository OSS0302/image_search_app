import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/image_item.dart';

class ImageItemWidget extends StatelessWidget {
  final ImageItem imageItem;
  const ImageItemWidget({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(imageItem.imageUrl,fit: BoxFit.cover,),);

  }
}
