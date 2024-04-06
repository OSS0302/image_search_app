import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';

class DetailScreen extends StatelessWidget {
  final PixabayItem imageItem;

  const DetailScreen({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageItem.tags),
      ),
      body: Hero(
        tag: imageItem.id,
        child: Image.network(
          imageItem.imageUrl,
          fit: BoxFit.cover,
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}
