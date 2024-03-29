import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final _pixabayRepository = PixabayRepositoryImpl();
  List<PixabayItem> imageItems = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItems = await _pixabayRepository.getImageItems(query);
    isLoading = false;
    notifyListeners();
  }
}
