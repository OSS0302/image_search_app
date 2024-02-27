import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;
   MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

   MainState _state =  MainState(imageItems: [], isLoading: false);

   MainState get state => _state;
  Future<void> fetchImage(String query) async{
    _state = state.copyWith(isLoading: true);
    notifyListeners();
   _state = state.copyWith(isLoading: false,imageItems: await _repository.getImageResult(query));
   notifyListeners();
  }


}