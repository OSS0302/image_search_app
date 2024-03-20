import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/ui/main/main_state.dart';




class HomeViewModel extends ChangeNotifier {
  final ImageRepository repository;

   HomeViewModel({
    required this.repository,
  });
    MainState _state = const MainState();

    MainState get state => _state;

  Future<void> fetchImage(String query) async{
    _state = state.copyWith(isLoading: true);
    notifyListeners();
      final result = (await repository.getSearchImage(query)).toList();
    _state = state.copyWith(
        isLoading: false,
        imageItems: result,
    );
    notifyListeners();
  }


}
