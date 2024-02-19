import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = PixabayImageItemRepositoryImpl();

  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);

  final _loadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _loadingController.stream;
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

  _imageItems = await repository.getImageResult(query);

    notifyListeners();

    isLoading =false;
    notifyListeners();
  }

}