import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/ui/main/main_event.dart';

import '../../data/model/image_item.dart';
import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _imageRepository;
  bool isLoading = false;
  List<ImageItem> imageItem = [];

  MainState _state = const MainState();

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventStream => _eventController.stream;


  MainViewModel({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _imageRepository.getImageItems(query);

    switch(result){
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data,
        );
        notifyListeners();
        _eventController.add(MainEvent.showSnackBar('성공'));

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
