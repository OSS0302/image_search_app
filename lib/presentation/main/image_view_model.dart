import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final _repository = ImageItemRepositoryImpl();
  List<ImageItem> _imageItems = [];
  bool isLoading = false;


  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    final imageItems = _repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();

  }
}