import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/reposiotory/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  final isLoading = false;
  List<ImageItem> _imageItem = [];

  List<ImageItem> get imageItems => List.unmodifiable(_imageItem);

  final _loadController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _loadController.stream;

  Future<void> searchImage(String query) async {
    _loadController.add(true);

    _imageItem = await repository.getImageResult(query);

    _loadController.add(false);

  }
}
