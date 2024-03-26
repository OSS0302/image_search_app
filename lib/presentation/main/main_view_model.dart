import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/image_search_use_case.dart';

import '../../domain/model/image_item.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageSearchUseCase _imageSearchUseCase;

  MainViewModel({
    required ImageSearchUseCase imageSearchUseCase,
  }) : _imageSearchUseCase = imageSearchUseCase;

  bool isLoading = false;
  List<ImageItem> imageItem = [];

  MainState _state = const MainState();

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventStream => _eventController.stream;




  Future<void> fetchImage(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _imageSearchUseCase.execute(query);

    switch(result){
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data,
        );
        notifyListeners();
        _eventController.add(const MainEvent.showSnackBar('성공'));

      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,

        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar(result.e.toString()));
      case Loading<List<ImageItem>>():

    }


    }


}
