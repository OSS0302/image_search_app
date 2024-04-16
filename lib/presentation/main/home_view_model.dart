import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/dto/image_dto.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';

class HomeViewModel extends ChangeNotifier {
  final _repository = ImageRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> imageItem = [];
  List<ImageItem> get imageItems => List.unmodifiable(imageItem);

  final loadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => loadingController.stream;

  Future<void> fetchImage(String query) async{
   loadingController.add(true);
   // isLoading = true;

    imageItem = await _repository.getImageSearch(query);
   loadingController.add(false);
    // isLoading = false;
    // notifyListeners();
  }
}
