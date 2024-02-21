import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/image_item.dart';

class DetailScreen extends StatelessWidget {
  final ImageItem imageItem;

  const DetailScreen({super.key,
    required this.imageItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지'),
      ),
      body: Hero(
          tag: imageItem.id,
          child: Column(
            children: [
              const Text('이미지 보기'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  imageItem.imageUrl,
                  width: 400,
                  height: 400,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )),
    );
  }
}
