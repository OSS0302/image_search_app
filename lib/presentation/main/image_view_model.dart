import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final   ImageItemRepository _repository;

  ImageViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItems = [];
  bool isLoading = false;

  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);



  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    final _imageItems = _repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();

  }


}