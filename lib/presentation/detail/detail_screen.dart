import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';

class DetailScreen extends StatelessWidget {
  final PixabayItem pixabayItem;

  const DetailScreen({super.key, required this.pixabayItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pixabayItem.imageUrl),
      ),
      body: Hero(
        tag: pixabayItem.id,
        child: Image.network(
          pixabayItem.imageUrl,
          fit: BoxFit.cover,
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}
