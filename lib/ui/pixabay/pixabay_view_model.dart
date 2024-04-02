import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final repository = PixabayRepositoryImpl();
  bool isLoading = false;
  List<PixabayItem> imageItems = [];

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItems = await repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();
  }
}
