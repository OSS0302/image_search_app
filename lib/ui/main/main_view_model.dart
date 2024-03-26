import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';
import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _imageRepository;
  bool isLoading = false;
  List<ImageItem> imageItem = [];


  MainState _state = MainState(
    isLoading: false,
    imageItems: List.unmodifiable([]),
  );

  MainState get state => _state;

  MainViewModel({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,

    );

    _state = state.copyWith(
      isLoading: false,
      imageItems: List.unmodifiable((await _imageRepository.getImageItems(query)).toList()),
    );
    notifyListeners();
  }
}
