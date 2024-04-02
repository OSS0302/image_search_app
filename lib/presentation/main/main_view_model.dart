import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/image_repository_imp.dart';
import 'package:image_search_app/domain/use_case/image_search_use_case.dart';
import 'package:image_search_app/presentation/main/main_event.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageSearchUseCase _imageSearchUseCase;

   MainViewModel({
    required ImageSearchUseCase imageSearchUseCase,
  }) : _imageSearchUseCase = imageSearchUseCase;

  MainState _state =
  MainState(
      isLoading: false,
      imageItems: List.unmodifiable([])
  );

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventStream => _eventController.stream;

  Future<void> searchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    final result = await _imageSearchUseCase.execute(query);

    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data,
        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar('성공!!'));
      case Error<List<ImageItem>>():

        _state = state.copyWith(
          isLoading: false,
        );
        _eventController.add(MainEvent.showSnackBar(result.e.toString()));
    }
  }


}
