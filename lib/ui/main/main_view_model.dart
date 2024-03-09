import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/ui/main/main_state.dart';


class MainViewModel extends ChangeNotifier {
  final ImageItemRepository  _repository;

   MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  MainState _state =  MainState(isLoading: false, imageItems: List.unmodifiable([]));

  
  MainState get state => _state;





  Future<void> searchImage(String query) async{
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(
      isLoading: false,
      imageItems: List.unmodifiable((await _repository.getImageData(query)).toList(),

    ));

   notifyListeners();
  }


}