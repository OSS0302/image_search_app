import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/domain/use_case/search_image_use_case.dart';
import 'package:image_search_app/presentation/main/pixabay_event.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';

import '../../domain/model/pixabay_item.dart';
import '../../domain/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final SearchImageUseCase _searchImageUseCase;
   PixabayViewModel({
    required SearchImageUseCase searchImageUseCase,
  }) : _searchImageUseCase = searchImageUseCase;


  PixabayState _state =
      PixabayState(imageItems: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  final _eventController = StreamController<PixabayEvent>();

  Stream<PixabayEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    final result = await _searchImageUseCase.execute(query);
    switch (result) {
      case Success<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: true,
          imageItems: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(const PixabayEvent.showSnackBar('성공'));
      case Error<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
        _eventController.add(PixabayEvent.showSnackBar(result.e.toString()));
    }
  }


}
