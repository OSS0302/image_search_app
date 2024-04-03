import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();

  List<ImageItem> imageItems = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItems = await _repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();

  }
}
