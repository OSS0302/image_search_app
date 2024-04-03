import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();

  List<ImageItem> _imageItems = [];
  bool isLoading = false;

  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);

  final _loadingController = StreamController<bool>();
  Stream<bool> get  loadingStream => _loadingController.stream;

  Future<void> fetchImage(String query) async {
    _loadingController.add(true);

    _imageItems = await _repository.getImageSearch(query);
    _loadingController.add(false);

  }
}
