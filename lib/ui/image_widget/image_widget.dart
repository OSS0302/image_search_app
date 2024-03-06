import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/image_model.dart';

class ImageWidget extends StatelessWidget {
  final ImageModel imageModel;
  const ImageWidget({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(imageModel.imageUrl,fit: BoxFit.cover,),
    );
  }
}
