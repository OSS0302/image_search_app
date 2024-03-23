import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel  extends ChangeNotifier {
  final PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;


  bool isLoading = false;
  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItem);

  Future<void> fetchImage(String query) async{
    isLoading = true;
    notifyListeners();

    _imageItem = await _repository.getImageItem(query);
    isLoading = false;
    notifyListeners();
  }


}