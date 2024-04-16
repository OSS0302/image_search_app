import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ImageRepository _repository;
   HomeViewModel({
    required ImageRepository repository,
  }) : _repository = repository;
  bool isLoading = false;
  List<ImageItem> imageItem = [];

  List<ImageItem> get imageItems => List.unmodifiable(imageItem);


  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItem = await _repository.getImageSearch(query);

    isLoading = false;
    notifyListeners();
  }
}
