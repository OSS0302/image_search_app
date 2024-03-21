import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/ui/main/home_event.dart';
import 'package:image_search_app/ui/main/home_state.dart';

class HomeViewModel extends ChangeNotifier {
  final ImageRepository repository;

  HomeViewModel({
    required this.repository,
  });

  HomeState _state = const HomeState();

  HomeState get state => _state;

  final _eventController = StreamController<HomeEvent>();
  Stream<HomeEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = (await repository.getSearchImage(query));

    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(HomeEvent.showSnackBar('성공!!'));
      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          
        );
        notifyListeners();
        _eventController.add(HomeEvent.showSnackBar(result.e.toString()));

      case Loading<List<ImageItem>>():
      // TODO: Handle this case.
    }

    notifyListeners();
  }
}
