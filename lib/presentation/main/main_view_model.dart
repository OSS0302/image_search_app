import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/reposiotory/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();

  bool _isLoading = false;
  bool  get  isLoading => _isLoading;

  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItem);



  Future<void> searchImage(String query) async {
    _isLoading = true;
    notifyListeners();

    _imageItem = await repository.getImageResult(query);

    _isLoading = false;
    notifyListeners();

  }
}
