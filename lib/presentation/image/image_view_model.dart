import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final  ImageRepository _repository;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state =  ImageState(imageItems: List.unmodifiable([],), isLoading: false);

  ImageState get state => _state;


  Future<void> fetchImage(String query) async{
    final result = await _repository.getImageItem(query);
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    switch(result) {

      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data
        );
      case Error<List<ImageItem>>():
        print('');
    }
  }
}