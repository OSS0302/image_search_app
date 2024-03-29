import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final _pixabayRepository = PixabayRepositoryImpl();
  List<PixabayItem> _imageItems = [];
  List<PixabayItem> get imageItem => List.unmodifiable(_imageItems);
  bool isLoading = false;

  final _loadController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _loadController.stream;

  Future<void> fetchImage(String query) async {
    _loadController.add(true);

    _imageItems = await _pixabayRepository.getImageItems(query);

    _loadController.add(false);
  }
}
