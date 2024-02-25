import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../domain/model/image_items.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();

  List<ImageItems> imageItems = [];

  bool isLoading = false;

  Future<void> fatchImage(String query) async {
    isLoading = true;
    notifyListeners();

    imageItems = await repository.getImageItems(query);
    isLoading = false;
    notifyListeners();
  }
}