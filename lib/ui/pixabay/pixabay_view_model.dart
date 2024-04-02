import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_search_app/data/core/result.dart';
import 'package:image_search_app/domain/use_case/search_image_usecase.dart';
import 'package:image_search_app/ui/pixabay/pixabay_event.dart';
import 'package:image_search_app/ui/pixabay/pixabay_state.dart';

import '../../domain/model/pixabay_item.dart';
import '../../domain/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final SearchImageUseCase _imageUseCase;

  PixabayViewModel({
    required SearchImageUseCase imageUseCase,
  }) : _imageUseCase = imageUseCase;

   PixabayState _state =  PixabayState(isLoading: false, imageItems: List.unmodifiable([]));

   PixabayState get state => _state;

  final _eventController = StreamController<PixabayEvent>();
  Stream<PixabayEvent> get eventStream => _eventController.stream;


  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );

      final result = await _imageUseCase.execute(query);
      switch(result){

        case Success<List<PixabayItem>>():
          _state = state.copyWith(
            isLoading: false,
            imageItems: result.data.toList()
          );
          notifyListeners();
          _eventController.add(const PixabayEvent.showSnackBar('성공!!!'));
        case Error<List<PixabayItem>>():
         _state = state.copyWith(
           isLoading: false,
         );
         notifyListeners();
         _eventController.add(PixabayEvent.showSnackBar(result.e.toString()));
      }



  }


}
