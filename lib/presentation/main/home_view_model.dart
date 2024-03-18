import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class HomeViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItem);

  Future<void> fetchImage(String query) async{
    _isLoading =true;
    notifyListeners();

    _imageItem = await repository.getSearchImage(query);
    _isLoading = false;
    notifyListeners();

  }
}
