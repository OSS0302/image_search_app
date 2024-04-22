import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';

class PixabayWdiget extends StatelessWidget {
  final PixabayItem pixabayItems;

  const PixabayWdiget({super.key, required this.pixabayItems});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        pixabayItems.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
