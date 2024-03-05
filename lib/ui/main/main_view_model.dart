import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/ui/main/main_state.dart';

import '../../data/model/image_model.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository repository;

  MainViewModel({
    required this.repository,
  });

  MainState _state =
      MainState(imageItems: List.unmodifiable([]), isLoading: false);

  MainState get state => _state;

  bool isLoading = false;
  List<ImageModel> _imageItems = [];

  List<ImageModel> get imageItems => List.unmodifiable(_imageItems);

  Future<bool> fatchImage(String query) async {
    try {
      final results = (await repository.getFatchImage(query)).toList();
      _state = state.copyWith(
        isLoading: false,
        imageItems: results,
      );
      notifyListeners();
      return true;
    } catch (e) {
      // SnackBar or Dialog
      return false;
    }
  }
}
