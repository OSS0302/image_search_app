import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final  PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

    PixabayState _state =   PixabayState(pixabayItem: List.unmodifiable([]), isLoading: false);

    PixabayState get state => _state;
  Future<void> fetchImage(String query) async {
    final result =  (await _repository.getfetchImage(query)).toList();
    _state =state.copyWith(
      isLoading: true
    );
    notifyListeners();

    _state =state.copyWith(
      pixabayItem: result,
      isLoading: false
    );

  }

}
