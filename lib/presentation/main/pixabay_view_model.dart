import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository = PixabayRepositoryImpl();
  List<PixabayItem> _imageItem = [];
  List<PixabayItem> get imageItem  => List.unmodifiable(_imageItem);

  bool isLoading = false;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;


  Future<void> fetchImage(String query) async {
    _loadingController.add(true);
    notifyListeners();

    _imageItem = await _repository.getResult(query);
    _loadingController.add(false);
    notifyListeners();
  }
}
