import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_event.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state =
      ImageState(imageItem: List.unmodifiable([]), isLoading: false);

  ImageState get state => _state;

  final _eventController  = StreamController<ImageEvent>();
  Stream<ImageEvent> get eventStream => _eventController.stream;

  Future<void> searchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = (await _repository.getImageItem(query));
    switch(result){

      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItem:  result.data,
        );
        notifyListeners();
        _eventController.add(const ImageEvent.showSnackBar('데이터가져오기 '));
        _eventController.add(const ImageEvent.showDialog('다이얼로그 생성'));

      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
        notifyListeners();
    }
  }
}
