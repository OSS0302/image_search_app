import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/repository/image_repository.dart';

import '../../domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
 final ImageRepository repository;
  MainViewModel({
   required this.repository,
 });

  bool isLoading = false;
  List<ImageItem> imageItems = [];

  Future<void>fetchImage(String query)async {
    isLoading = true;
    notifyListeners();

    imageItems = await repository.getImageItem(query);
    isLoading = false;
    notifyListeners();
  }


}