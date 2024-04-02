import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;
   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;


  bool isLoading = false;
  List<PixabayItem> _imageItems = [];
  List<PixabayItem> get  imageItems => List.unmodifiable(_imageItems);

  Future<void> fetchImage(String query) async {
    isLoading = true;

    _imageItems = await _repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();
  }


}
