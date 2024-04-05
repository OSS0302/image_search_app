import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final  PixabayRepository _repository ;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =  PixabayState(imageItems: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    _state = state.copyWith(
     isLoading: false,
     imageItems: (await _repository.getImageSearch(query)).toList(),
   );
    notifyListeners();
  }


}