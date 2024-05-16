import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'main_event.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  MainState _state =
      MainState(imageItem: List.unmodifiable([]), isLoading: false);

  MainState get state => _state;
  
  final _eventController = StreamController<MainEvent>();

  Stream<MainEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = await _repository.getImageItems(query);
    switch(result){

      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItem: result.data.toList()
        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar('성공'));
        _eventController.add(MainEvent.showDialog('다이얼로그'));

      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
        notifyListeners();
    }
  }
}
