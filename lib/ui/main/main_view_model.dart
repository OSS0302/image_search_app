import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';

import '../../data/model/image_item.dart';

class MainViewModel extends ChangeNotifier {
  final  repository = ImageItemRepositoryImpl();
  bool isLoading = false;
  List<ImageItem> imageItems = [];


  Future<void> searchImage(String query) async{
    isLoading = true;
    notifyListeners();

   imageItems = await repository.getImageData(query);
   isLoading = false;
   notifyListeners();
  }

}