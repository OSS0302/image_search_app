import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final repository = PixabayRepositoryImpl();
  bool isLoading = false;
  List<PixabayItem> _imageItems = [];
  List<PixabayItem> get  imageItems => List.unmodifiable(_imageItems);

  final _loadController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadController.stream;


  Future<void> fetchImage(String query) async {
    _loadController.add(true);

    _imageItems = await repository.getImageSearch(query);
    _loadController.add(false);
    notifyListeners();
  }
}
