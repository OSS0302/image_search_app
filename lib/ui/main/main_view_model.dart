import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _imageRepository;
  bool isLoading = false;
  List<ImageItem> imageItems = [];

  MainViewModel({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<void> fetchImage(String query) async {
    isLoading = false;
    notifyListeners();

    imageItems = await _imageRepository.getImageItems(query);
    isLoading = true;
    notifyListeners();
  }
}
