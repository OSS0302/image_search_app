import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/image_use_case.dart';
import 'package:image_search_app/ui/main/main_event.dart';
import 'package:image_search_app/ui/main/main_state.dart';

import '../../domain/model/pixabay_item.dart';
import '../../domain/repository/pixabay_repository.dart';

class MainViewModel extends ChangeNotifier {
  final ImageUseCase _imageUseCase;

  MainViewModel({
    required ImageUseCase imageUseCase,
  }) : _imageUseCase = imageUseCase;

  MainState _state =
      MainState(isLoading: false, pixabayItem: List.unmodifiable([]));

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();

  Stream<MainEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = (await _imageUseCase.execute(query));
    switch(result){

      case Success<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: false,
          pixabayItem: result.data
        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar('성공'));
        _eventController.add(MainEvent.showDialog('다이얼로그'));
      case Error<List<PixabayItem>>():
        // TODO: Handle this case.
    }
  }


}
