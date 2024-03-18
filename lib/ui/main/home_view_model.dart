import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class HomeViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItem);

  Future<void> fetchImage(String query) async{
    isLoading =true;
    notifyListeners();

    _imageItem = await repository.getSearchImage(query);
    isLoading = false;
    notifyListeners();

  }
}
