import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/domain/model/image_item.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _repository;
   MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItems = [];
  bool _isLoading = false;
  List<ImageItem> get  imageItem => List.unmodifiable(_imageItems);
  bool get isLoading =>_isLoading;





  Future<void> fetchImage(String query) async{
    _isLoading =true;
    notifyListeners();
   _imageItems = await _repository.getImageResult(query);
    _isLoading =false;
   notifyListeners();
  }


}