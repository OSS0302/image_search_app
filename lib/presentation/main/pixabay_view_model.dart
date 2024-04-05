import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';


class PixabayViewModel extends ChangeNotifier {
  final  PixabayRepository _repository ;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =  PixabayState(imageItems: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  Future<bool> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    try{
      final result = (await _repository.getImageSearch(query)).toList();
      _state = state.copyWith(
        isLoading: false,
        imageItems: result,
      );
      notifyListeners();
      return true;
    }catch(e){
      return false;
    }
  }
}