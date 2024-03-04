import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';

import '../../data/model/image_model.dart';

class MainViewModel extends ChangeNotifier {
  final repository = ImageItemRepositoryImpl();
  bool isLoading = false;
  List<ImageModel> imageItems = [];

  Future<void> fatchImage(String query) async{
    isLoading = true;
    notifyListeners();

    imageItems = await repository.getFatchImage(query);
    isLoading = false;
    notifyListeners();
  }

}