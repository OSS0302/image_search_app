import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRespositoryImpl();
  List<ImageItem> imageItems = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();
    imageItems = await repository.getImageItem(query);
    isLoading =false;
    notifyListeners();

  }
}
