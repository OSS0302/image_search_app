import 'package:flutter/material.dart';

import '../../data/repository/image_item_repository_impl.dart';
import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageItemRepositoryImpl();

  List<ImageItem> imageItems = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();
    imageItems = await repository.getImageItems(query);
    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    return Future.delayed(const Duration(seconds: 2));
  }
}
