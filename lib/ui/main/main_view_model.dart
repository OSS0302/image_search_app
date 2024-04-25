import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/ui/main/main_state.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class MainViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

  MainViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  MainState _state =
      MainState(isLoading: false, pixabayItem: List.unmodifiable([]));

  MainState get state => _state;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = (await _repository.getPixabayItem(query));
    switch(result){

      case Success<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: false,
          pixabayItem: result.data
        );
        notifyListeners();
      case Error<List<PixabayItem>>():
        // TODO: Handle this case.
    }
  }
}
