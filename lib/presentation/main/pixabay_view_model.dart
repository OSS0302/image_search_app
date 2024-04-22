import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository = PixabayRepositoryImpl();

  List<PixabayItem> _pixabayItem = [];

  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  bool isLoading = false;
  final isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => isLoadingController.stream;


  Future<void> fetchImage(String query) async {
    isLoadingController.add(true);

    _pixabayItem = await _repository.getImageSearch(query);
    isLoadingController.add(false);

  }
}
