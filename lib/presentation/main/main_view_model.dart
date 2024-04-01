import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> imageItem = [];

  Future<void> searchImage(String query) async {
    isLoading = true;
    notifyListeners();

   imageItem = await repository.getImageSearch(query);
   isLoading = false;
   notifyListeners();
  }

}