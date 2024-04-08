import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/presentation/main/main_event.dart';
import 'package:image_search_app/presentation/main/main_state.dart';
import '../../domain/model/image_item.dart';
import '../../domain/use_case/search_use_case.dart';


class MainViewModel extends ChangeNotifier {
  final SearchUseCase _searchUseCase;

   MainViewModel({
    required SearchUseCase searchUseCase,
  }) : _searchUseCase = searchUseCase;

  MainState _state =
  MainState(isLoading: false, imageItems: List.unmodifiable([]));

  MainState get state => _state;

  final eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventstream => eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = (await _searchUseCase.execute(query));
    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(imageItems: result.data.toList(), isLoading: false);
        eventController.add(const MainEvent.showSnackBar('성공!!!'));
        notifyListeners();

      case Error<List<ImageItem>>():
        _state = state.copyWith(isLoading: false);
        eventController.add(MainEvent.showSnackBar(result.e.toString()));
    }
  }
}
