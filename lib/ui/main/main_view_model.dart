import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/ui/main/main_state.dart';

import '../../core/result.dart';
import '../../data/model/image_model.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository repository;

  MainViewModel({
    required this.repository,
  });

  MainState _state =
      MainState(imageItems: List.unmodifiable([]), isLoading: false);

  MainState get state => _state;

  bool isLoading = false;
  List<ImageModel> _imageItems = [];

  List<ImageModel> get imageItems => List.unmodifiable(_imageItems);

  Future<void> fatchImage(String query) async {
    // 화면갱신
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await repository.getFatchImage(query);

    switch(result) {
      case Success<List<ImageModel>>():
      // 화면갱신
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data.toList(),
        );
        notifyListeners();
      case Error<List<ImageModel>>():
      // TODO: 스낵바
        print('error!!!!!!!!!!!');
      case loading<List<ImageModel>>():
      // TODO: 로딩
        print('loading');
    }
  }
}