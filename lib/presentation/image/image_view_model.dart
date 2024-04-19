import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final   ImageRepository  _repository;
   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;


  ImageState _state =  ImageState(imageItem: List.unmodifiable([]), isLoadidng: false);

  ImageState get state => _state;

  Future<void> searchImage(String query) async {
    final result = (await _repository.getImageItem(query)).toList();
    _state = state.copyWith(
      isLoadidng: true,
    );
    notifyListeners();
    _state = state.copyWith(
      isLoadidng: false,
      imageItem: result,
    );
  }


}
