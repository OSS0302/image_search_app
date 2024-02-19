import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/image_repository/repository.dart';
import 'package:image_search_app/domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = PixabayImageItemRepositoryImpl();

  List<ImageItem> imageItems = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

  imageItems = await repository.getImageResult(query);
    notifyListeners();

    isLoading =false;
    notifyListeners();
  }

}