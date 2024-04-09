import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  List<PixabayItem> _imageItem = [];
  List<PixabayItem> get imageItem  => List.unmodifiable(_imageItem);

  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _imageItem = await _repository.getResult(query);
    isLoading = false;
    notifyListeners();
  }


}
