import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final   ImageRepository  _repository;
   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;


  List<ImageItem> _imageItem = [];
  List<ImageItem> get  imageItem => List.unmodifiable(_imageItem);
  bool isLoadidng = false;

  final _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> searchImage(String query) async {
    isLoadidng = true;
    notifyListeners();

    _imageItem = await _repository.getImageItem(query);
    isLoadidng = false;
    notifyListeners();
  }


}
