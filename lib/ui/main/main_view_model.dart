import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/model/image_item.dart';
import '../../domain/repository/image_item_repository.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;

   MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;



  List<ImageItem> imageItems = [];

  List<ImageItem> get imageItem => List.unmodifiable(imageItems);


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchImage(String query) async {
    _isLoading = true;
  notifyListeners();

    imageItems = await _repository.getImageItems(query);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    return Future.delayed(const Duration(seconds: 2));
  }

}
