import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/ui/pixabay/pixabay_state.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;
   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

   PixabayState _state =  PixabayState(isLoading: false, imageItems: List.unmodifiable([]));

   PixabayState get state => _state;


  Future<bool> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    try {
      final result = await _repository.getImageSearch(query);
      _state = state.copyWith(
          imageItems: result,
          isLoading: false,
      );
      notifyListeners();
      return true;
    }catch(e) {
      return false;
    }

  }


}
