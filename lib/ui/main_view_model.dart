import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/domain/image_repository/repository.dart';

import '../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;

  MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;
  List<ImageItem> _imageItems = [];

  List<ImageItem> get imageItem => List.unmodifiable(_imageItems);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> searchImage(String query) async {
    _isLoading = true;
    notifyListeners();

    _imageItems = await _repository.getImageResult(query);
    notifyListeners();

    _isLoading = false;
    notifyListeners();
  }
}
