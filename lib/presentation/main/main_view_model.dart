import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/use_case/image_use_case.dart';
import 'package:image_search_app/presentation/main/main_event.dart';
import '../../domain/model/image_item.dart';
import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageUseCase _imageUseCase;

   MainViewModel({
    required ImageUseCase imageUseCase,
  }) : _imageUseCase = imageUseCase;

  MainState _state =
      MainState(isLoading: false, imageItems: List.unmodifiable([]));

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();

  Stream<MainEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = (await _imageUseCase.execute(query));
    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data,
        );
        _eventController.add(MainEvent.showSnackBar('성공!'));
        _eventController.add(MainEvent.showDialog('완료'));
      case Error<List<ImageItem>>():
        _state.copyWith(isLoading: false);
        _eventController.add(MainEvent.showSnackBar(result.e.toString()));
    }
  }
}
