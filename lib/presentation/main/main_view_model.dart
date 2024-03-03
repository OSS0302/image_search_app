import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/repository/image_repository.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
 final ImageRepository repository;
  MainViewModel({
   required this.repository,
 });
  MainState _state =  MainState(
      imageItems: List.unmodifiable([]),
      isLoading: false

  );

  MainState get state => _state;

  Future<void>fetchImage(String query)async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    _state = state.copyWith(isLoading: false, imageItems: List.unmodifiable(await repository.getImageItem(query)));
    notifyListeners();
  }


}