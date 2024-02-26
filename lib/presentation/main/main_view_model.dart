import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/domain/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageItemRepositoryImpl();
  List<ImageItem> _imageItems = [];
  bool isLoading = false;
  List<ImageItem> get  imageItem => List.unmodifiable(_imageItems);

  final _loadController = StreamController<bool>();
  Stream<bool>get isLoadingStream => _loadController.stream;



  Future<void> fetchImage(String query) async{
   _loadController.add(true);

   _imageItems = await repository.getImageResult(query);
   _loadController.add(false);
   notifyListeners();
  }

}