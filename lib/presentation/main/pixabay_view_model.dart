import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';

import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

  PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =  PixabayState(pixabayItem: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  Future<void> fetchImage(String query) async {

    _state = state.copyWith(
      isLoading: true);
    notifyListeners();

    final result = await _repository.getImageSearch(query);
      switch(result){

        case Success<List<PixabayItem>>():
          _state = state.copyWith(
            isLoading: false,
            pixabayItem: result.data.toList(),
          );
          notifyListeners();
        case Error<List<PixabayItem>>():
          // TODO: Handle this case.
      }


  }
}
