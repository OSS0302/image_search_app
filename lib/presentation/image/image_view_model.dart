import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();


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