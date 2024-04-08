import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _repository;
   MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);
  bool isLoading = false;

  final loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => loadingController.stream;



  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _imageItems = await _repository.getImage(query);
    isLoading = false;
    notifyListeners();
  }


}
