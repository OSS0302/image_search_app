import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/ui/main/main_event.dart';
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
  final _eventController = StreamController<MainEvent>();
  Stream<MainEvent> get eventStream => _eventController.stream;

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
        _eventController.add(const MainEvent.showSnackBar('성공'));
      case Error<List<ImageModel>>():
      _state = state.copyWith(
        isLoading: false,
      );
      notifyListeners();
      _eventController.add(MainEvent.showSnackBar(result.e.toString()));
      case loading<List<ImageModel>>():
      // TODO: 로딩
        print('loading');
    }
  }
}