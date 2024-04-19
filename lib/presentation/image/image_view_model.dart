import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();
  List<ImageItem> imageItem = [];
  bool isLoaidng = false;

  Future<void> searchImage(String query) async {
    isLoaidng = true;
    notifyListeners();

    imageItem = await _repository.getImageItem(query);
    isLoaidng = false;
    notifyListeners();
  }
}
