import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;
   MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  Future<void> searchImage(String query) async {
    // 화면갱신
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getImageResult(query);

    switch (result) {
      case Success<List<ImageItem>>():
      // 화면갱신
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data.toList(),
        );
        notifyListeners();
      case Error<List<ImageItem>>():
      // TODO: 스낵바
        print('error!!!!!!!!!!!');
      case Loading<List<ImageItem>>():
      // TODO: 로딩
        print('loading');
    }
    }
  }