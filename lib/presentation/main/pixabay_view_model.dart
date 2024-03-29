import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _pixabayRepository;

   PixabayViewModel({
    required PixabayRepository pixabayRepository,
  }) : _pixabayRepository = pixabayRepository;


  List<PixabayItem> _imageItems = [];
  List<PixabayItem> get imageItem => List.unmodifiable(_imageItems);
  bool _isLoading = false;
  bool get  isLoading  => _isLoading;



  Future<void> fetchImage(String query) async {
    _isLoading = true;
    notifyListeners();

    _imageItems = await _pixabayRepository.getImageItems(query);

    _isLoading = false;
    notifyListeners();
  }
}
