import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository  _repository;

   MainViewModel({
    required ImageItemRepository repository,
  }) : _repository = repository;

  bool _isLoading = false;
  bool get isLoading  =>_isLoading;

  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItems);




  Future<void> searchImage(String query) async{
    _isLoading = true;
    notifyListeners();

   _imageItems = await _repository.getImageData(query);
    _isLoading = false;
   notifyListeners();
  }


}