import 'package:flutter/material.dart';

import '../../domain/model/pixabay_item.dart';

class PixabayWidget extends StatelessWidget {
  final PixabayItem imageItem;

  const PixabayWidget({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageItem.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
