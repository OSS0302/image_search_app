import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

class MainViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();
  List<ImageItem> _imageItem = [];
  List<ImageItem> get  imageItem => List.unmodifiable(_imageItem);
  bool isLoading = false;

  final _loadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _loadingController.stream;



  Future<void> searchImage(String query) async {
    _loadingController.add(true);

   _imageItem = await _repository.getImageSearch(query);
    _loadingController.add(false);
  }
}
