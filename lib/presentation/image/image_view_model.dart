import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final  ImageRepository _repository;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItems = [];
  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);

  bool isLoading = false;


  Future<void> fetchImage(String query) async{
    isLoading = true;
    notifyListeners();

    _imageItems = await _repository.getImageItem(query);
    isLoading = false;
    notifyListeners();
  }
}