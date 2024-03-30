import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _pixabayRepository;

   PixabayViewModel({
    required PixabayRepository pixabayRepository,
  }) : _pixabayRepository = pixabayRepository;

   PixabayState _state =  PixabayState(imageItems: List.unmodifiable([]), isLoading: false);

   PixabayState get state => _state;

  Future<void> fetchImage(String query) async {

    final result = await _pixabayRepository.getImageItems(query);
    switch(result){
      case Success<List<PixabayItem>>():
        _state = state.copyWith(isLoading: true, imageItems: result.data.toList());
      case Error<List<PixabayItem>>():
        _state = state.copyWith(isLoading: false);
    }
  }
}
