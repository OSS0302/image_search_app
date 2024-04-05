import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository = PixabayRepositoryImpl();
  List<PixabayItem> _imageItems = [];
  bool isLoading = false;

  List<PixabayItem> get imageItems => List.unmodifiable(_imageItems);

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

   _imageItems = await _repository.getImageSearch(query);
   isLoading = false;
   notifyListeners();
  }

}