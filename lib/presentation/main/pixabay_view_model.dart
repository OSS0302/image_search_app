import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository = PixabayRepositoryImpl();
  List<PixabayItem> _imageItems = [];
  bool isLoading = false;

  List<PixabayItem> get imageItems => List.unmodifiable(_imageItems);

  final _loadingController = StreamController<bool>();

  Stream<bool> get loadingStream => _loadingController.stream;

  Future<void> fetchImage(String query) async {
    _loadingController.add(true);

    _imageItems = await _repository.getImageSearch(query);
    _loadingController.add(false);
  }
}
