import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_state.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state =
      ImageState(isLoading: false, imageItem: List.unmodifiable([]));

  ImageState get state => _state;

  Future<void> fetchImage(String query) async {
    final result = (await _repository.getResult(query)).toList();
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    _state = state.copyWith(
      isLoading: false,
      imageItem: result.toList()
    );
    notifyListeners();
  }
}
