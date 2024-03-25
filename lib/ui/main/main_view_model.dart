import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> _imageItems = [];

  List<ImageItem> get imageItem => List.unmodifiable(_imageItems);

  final _loadController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _loadController.stream;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _imageItems = await repository.getImageItems(query);
    isLoading = false;
    notifyListeners();
  }
}