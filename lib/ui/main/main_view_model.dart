import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/ui/main/main_event.dart';
import 'package:image_search_app/ui/main/main_state.dart';

import '../../core/result.dart';
import '../../domain/model/image_model.dart';
import '../../domain/use_case/search_image_usecase.dart';

class MainViewModel extends ChangeNotifier {
  final SearchImageUseCase _searchImageUseCase;

  MainViewModel({
    required SearchImageUseCase searchImageUseCase,
  })  : _searchImageUseCase = searchImageUseCase;

  MainState _state = MainState();

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventStream => _eventController.stream;

  Future<void> fatchImage(String query) async {
    // 화면갱신
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _searchImageUseCase.execute(query);

    switch(result) {
      case Success<List<ImageModel>>():
      // 화면갱신
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(const MainEvent.showSnackBar('성공'));
      case Error<List<ImageModel>>():
      _state = state.copyWith(
        isLoading: false,
      );
      notifyListeners();
      _eventController.add(MainEvent.showSnackBar(result.e.toString()));
      case loading<List<ImageModel>>():
      // TODO: 로딩
        print('loading');
    }
  }


}