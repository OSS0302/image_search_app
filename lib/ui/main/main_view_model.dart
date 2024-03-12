import 'package:flutter/material.dart';
import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class MainViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  bool isLoading = false;
  List<ImageItem> _imageItems = [];

  List<ImageItem> get imageItems => List.unmodifiable(_imageItems);

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _imageItems = await _repository.getImageSearch(query);
    isLoading = false;
    notifyListeners();
  }
}
