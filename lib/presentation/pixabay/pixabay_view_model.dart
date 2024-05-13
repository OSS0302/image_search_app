import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_state.dart';

import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {

  final PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state = PixabayState(pixabayItem: List.unmodifiable([]), isLoading: false);

  PixabayState get state => _state;


  Future<bool> fetchImage(String query) async{
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    try {
      final result = await _repository.getPixabayItem(query);
      _state = state.copyWith(
        isLoading: false,
        pixabayItem: result,
      );
      notifyListeners();
      return true;
    }catch(e) {
      return false;
    }

  }
}