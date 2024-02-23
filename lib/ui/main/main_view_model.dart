import 'package:flutter/material.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/ui/main/main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;

  MainState _state =
      MainState(
          imageItems: List.unmodifiable([]),
          isLoading: false,
      );

  MainState get state => _state;

  MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;



  Future<void> fetchImage(String query) async {
    _state =state.copyWith(isLoading: true);
    notifyListeners();


    _state= state.copyWith(
        imageItems: List.unmodifiable(await _repository.getImageData(query)),
        isLoading: false);
    notifyListeners();
  }
}
