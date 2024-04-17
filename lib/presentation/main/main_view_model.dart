import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

class MainViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();
  List<ImageItem> imageItem = [];
  bool isLoading = false;

  Future<void> searchImage(String query) async {
    isLoading = true;
    notifyListeners();

   imageItem = await _repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();
  }
}
