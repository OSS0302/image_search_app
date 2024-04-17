import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/presentation/main/main_event.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../domain/model/image_item.dart';
import '../../domain/use_case/image_use_case.dart';

class MainViewModel extends ChangeNotifier {
  final ImageUseCase _imageUseCase;

  MainViewModel({
    required ImageUseCase imageUseCase,
  }) : _imageUseCase = imageUseCase;

  MainState _state =
      MainState(isLoading: false, imageItem: List.unmodifiable([]));

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();

  Stream<MainEvent> get eventStream => _eventController.stream;

  Future<void> searchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = (await _imageUseCase.execute(query));
    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItem: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar('성공!!입니다.'));
        _eventController.add(MainEvent.showDialog('다이얼로그!.'));
      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
    }
  }
}
