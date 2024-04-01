import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  MainState _state =
  MainState(
      isLoading: false,
      imageItems: List.unmodifiable([])
  );

  MainState get state => _state;

  Future<void> searchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    final result = await _repository.getImageSearch(query);
    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data,
        );
      case Error<List<ImageItem>>():


    }
  }
}
