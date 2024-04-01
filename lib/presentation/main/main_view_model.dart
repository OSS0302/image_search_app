import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;


  Future<void> searchImage(String query) async {
    _loadingController.add(true);

   _imageItems = await repository.getImageSearch(query);
    _loadingController.add(false);
  }

}