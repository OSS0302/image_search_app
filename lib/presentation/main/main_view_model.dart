import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();
  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);
  bool isLoading = false;

  final loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => loadingController.stream;



  Future<void> fetchImage(String query) async {
    loadingController.add(true);

    _imageItems = await _repository.getImage(query);
    loadingController.add(false);
  }
}
