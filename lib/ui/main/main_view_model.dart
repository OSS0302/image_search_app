import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;

  MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItems = [];

  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _imageItems = await _repository.getImageResult(query);
    isLoading = false;
    notifyListeners();
  }
}
