import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_state.dart';

import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

  PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =
      PixabayState(pixabayItem: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  final eventController = StreamController<PixabayEvent>();
  Stream<PixabayEvent> get eventStream => eventController.stream;

  Future<void> fetchImage(String query) async {
    final result = (await _repository.getfetchImage(query));
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    switch(result){

      case Success<List<PixabayItem>>():
       _state = state.copyWith(
        isLoading: false,
         pixabayItem: result.data,
       );
       notifyListeners();
       eventController.add(const PixabayEvent.showSnackBar('데이터 가져오기 완료'));
       eventController.add(const PixabayEvent.showDialog('데이터 가져오기 완료'));
      case Error<List<PixabayItem>>():
        print('에얼');
    }
  }
}
