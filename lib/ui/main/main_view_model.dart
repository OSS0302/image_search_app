import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = PixabayRepositoryImpl();
  bool isLoading = false;
  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  Future<void> fetchImage(String query) async{
    isLoading = true;
    notifyListeners();

   _pixabayItem = await repository.getPixabayItem(query);
    isLoading = false;
    notifyListeners();
  }
}
