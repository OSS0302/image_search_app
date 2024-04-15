import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> imageItems = [];

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItems = await _repository.getfetchImage(query);

    isLoading = false;
    notifyListeners();
  }
}
