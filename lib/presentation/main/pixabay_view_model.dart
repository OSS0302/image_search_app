import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_event.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';


class PixabayViewModel extends ChangeNotifier {
  final  PixabayRepository _repository ;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =  PixabayState(imageItems: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  final _eventController = StreamController<PixabayEvent>();
  Stream<PixabayEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = (await _repository.getImageSearch(query));
    switch(result) {

      case Success<List<PixabayItem>>():
        _state =state.copyWith(
          isLoading: false,
          imageItems: result.data
        );
        notifyListeners();
        _eventController.add(PixabayEvent.showSnackBar('성공!!'));
      case Error<List<PixabayItem>>():
        _state =state.copyWith(
            isLoading: false,
        );
        notifyListeners();
       _eventController.add(PixabayEvent.showSnackBar(result.e.toString()));
    }


  }
}