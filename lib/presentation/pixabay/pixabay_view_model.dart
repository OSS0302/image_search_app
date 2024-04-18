import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository = PixabayRepositoryImpl();

  List<PixabayItem> pixabayItem = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async{
    isLoading = true;
    notifyListeners();

    pixabayItem = await _repository.getfetchImage(query);
    isLoading = false;
    notifyListeners();
  }
}