import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';

class MainViewModel extends ChangeNotifier{
  final _repository = ImageItemRepositoryImpl();
 bool isLoading = false;
 List<ImageItem> _imageItems = [];
 List<ImageItem> get  imageItems =>  List.unmodifiable(_imageItems);

 Future<void> fetchImage(String query) async{
   isLoading = true;
   notifyListeners();

   _imageItems = await _repository.getSearchImage(query);
   isLoading = false;
   notifyListeners();
 }

}