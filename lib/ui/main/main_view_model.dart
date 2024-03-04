import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';

import '../../data/model/image_model.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageItemRepositoryImpl();
  bool isLoading = false;
  List<ImageModel> _imageItems = [];
  List<ImageModel> get imageItems => List.unmodifiable(_imageItems);

  final loadingController = StreamController<bool>();
  Stream<bool>get isLoadingStream => loadingController.stream;


  Future<void> fatchImage(String query) async{
    isLoading = true;
    notifyListeners();

    _imageItems = await repository.getFatchImage(query);
    isLoading = false;
    notifyListeners();
  }

}