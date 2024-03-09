import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final  repository = ImageItemRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItems);

  final  loadController = StreamController<bool>();
  Stream<bool> get isLoadingStream => loadController.stream;


  Future<void> searchImage(String query) async{
    loadController.add(true);
    notifyListeners();

   _imageItems = await repository.getImageData(query);
    loadController.add(false);
   notifyListeners();
  }

}