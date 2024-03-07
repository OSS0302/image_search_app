import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/image_model.dart';

class DetailScreen extends StatelessWidget {
  final ImageModel imageModel;
  const DetailScreen({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(imageModel.tags),
      ),
      body: Hero(tag: imageModel.id,
      child: Image.network(imageModel.imageUrl,fit: BoxFit.cover,width: 400,height: 400,)),
    );
  }
}
