import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  MainState _state =
      MainState(isLoading: false, imageItems: List.unmodifiable([]));

  MainState get state => _state;

  final loadingController = StreamController<bool>();

  Stream<bool> get loadingStream => loadingController.stream;

  Future<bool> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    try {
      final result = (await _repository.getImage(query)).toList();

      _state = state.copyWith(
        isLoading: false,
        imageItems: result,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
