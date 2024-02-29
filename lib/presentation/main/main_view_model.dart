import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/presentation/main/main_event.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../core/result.dart';
import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;

  MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  final _eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventStream => _eventController.stream;

  MainState _state = MainState(imageItems: [], isLoading: false);

  MainState get state => _state;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getImageResult(query);

    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar('성공!'));
      case Error<List<ImageItem>>():
          _state = state.copyWith(isLoading:  false);
          notifyListeners();

        _eventController.add(MainEvent.showSnackBar(result.e.toString()));
      case Loading<List<ImageItem>>():
         print('로딩');
    }
  }
}
