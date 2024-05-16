import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/main/main_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class MainViewModel extends ChangeNotifier {
  final  ImageRepository _repository;

   MainViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  MainState _state =  MainState(imageItem: List.unmodifiable([]), isLoading: false);

  MainState get state => _state;
  Future<void> fetchImage(String query) async {
    final result =  await _repository.getImageItems(query);
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();


    _state = state.copyWith(
      isLoading: false,
      imageItem: result,
    );
    notifyListeners();
  }


}
