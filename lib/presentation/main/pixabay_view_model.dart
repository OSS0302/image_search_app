import 'dart:async';

import 'package:flutter/material.dart';
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
    _state = state.copyWith(
      isLoading: true,
    );
    _state = state.copyWith(
      imageItems: List.unmodifiable((await _pixabayRepository.getImageItems(query)).toList()),
      isLoading: false,

    );
  }
}
