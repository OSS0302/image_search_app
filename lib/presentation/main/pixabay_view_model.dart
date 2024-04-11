import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/search_use_case.dart';
import 'package:image_search_app/presentation/main/pixabay_event.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';

import '../../domain/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final SearchUseCase _searchUseCase;

  PixabayViewModel({
    required SearchUseCase searchUseCase,
  }) : _searchUseCase = searchUseCase;

  PixabayState _state =
      PixabayState(imageItems: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  final _eventController = StreamController<PixabayEvent>();

  Stream<PixabayEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = (await _searchUseCase.execute(query));
    switch (result) {
      case Success<List<PixabayItem>>():
        _state = state.copyWith(isLoading: false, imageItems: result.data);
        notifyListeners();
        _eventController.add(PixabayEvent.showSnackBar('성공!!'));
        _eventController.add(PixabayEvent.showDialog('성공!!!'));
      case Error<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
        notifyListeners();
        _eventController.add(PixabayEvent.showSnackBar(result.e.toString()));
    }
  }
}
