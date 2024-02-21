import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/repository/image_item_repository_impl.dart';
import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageItemRepositoryImpl();
  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);
  bool isLoading = false;

  final _loadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _loadingController.stream;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _imageItems = await repository.getImageResult(query);
    isLoading = false;
    notifyListeners();
  }
}
