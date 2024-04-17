import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository  _repository ;

   MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  MainState _state =  MainState(isLoading: false, imageItem: List.unmodifiable([]));

  MainState get state => _state;




  Future<void> searchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    _state = state.copyWith(
      isLoading: false,
      imageItem: (await _repository.getImageSearch(query)).toList()
    );
    notifyListeners();
  }


}
