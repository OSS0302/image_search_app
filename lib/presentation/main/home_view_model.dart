import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/presentation/main/home_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  HomeViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  HomeState _state =
      HomeState(isLoading: false, imageItem: List.unmodifiable([]));

  HomeState get state => _state;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    final result = (await _repository.getImageSearch(query));
      switch(result){
        case Success<List<ImageItem>>():
          _state = state.copyWith(
            isLoading: false,
            imageItem: result.data
          );
        case Error<List<ImageItem>>():
          _state = state.copyWith(
             isLoading: false
          );
      }
  }
}
