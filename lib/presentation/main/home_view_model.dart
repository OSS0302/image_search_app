import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/image_use_case.dart';
import 'package:image_search_app/presentation/main/home_event.dart';
import 'package:image_search_app/presentation/main/home_state.dart';

import '../../domain/model/image_item.dart';
import '../../domain/repository/image_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ImageUseCase _imageUseCase;
   HomeViewModel({
    required ImageUseCase imageUseCase,
  }) : _imageUseCase = imageUseCase;


  HomeState _state =
      HomeState(isLoading: false, imageItem: List.unmodifiable([]));

  HomeState get state => _state;

  final _eventController = StreamController<HomeEvent>();
  Stream<HomeEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = (await _imageUseCase.execute(query));
      switch(result){
        case Success<List<ImageItem>>():
          _state = state.copyWith(
            isLoading: false,
            imageItem: result.data
          );
          notifyListeners();
          _eventController.add(HomeEvent.showSnackBar('성공'));
          _eventController.add(HomeEvent.showDialog('성공'));
        case Error<List<ImageItem>>():
          _state = state.copyWith(
             isLoading: false
          );
      }
  }


}
