import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> imageItems = [];

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItems = await repository.getImageItems(query);
    isLoading = false;
    notifyListeners();
  }
}