import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/ui/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel  extends ChangeNotifier {
  final PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =  PixabayState(isLoading: false, imageItems: []);

  PixabayState get state => _state;

  List<ImageItem> get imageItem => List.unmodifiable(imageItem);

  Future<void> fetchImage(String query) async{
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(
      imageItems: List.unmodifiable((await _repository.getImageItem(query)).toList()),
      isLoading: false,
    );
    notifyListeners();
  }


}