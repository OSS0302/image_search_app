// import 'dart:async';

import 'dart:async';
import 'dart:developer';

import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/domain/use_case/search_use_case.dart';
import 'package:image_search_app/presentation/main/pixabay_event.dart';
import 'package:image_search_app/presentation/main/pixabay_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pixabay_view_model.g.dart';

@riverpod
class PixabayViewModel extends _$PixabayViewModel {
  late final SearchUseCase _searchUseCase;
  final _eventController = StreamController<PixabayEvent>();
  Stream<PixabayEvent> get eventStream => _eventController.stream;

  @override
  Future<PixabayState> build() async {

    _searchUseCase = getIt<SearchUseCase>();
    List<PixabayItem> stateTemp = [];

    await getImageList("apple").then((value) async {
      value.when(
          success: (success) {
            stateTemp = success;
          },
          error: (error) {
            log('에러임: $error');
          });
    });
    return PixabayState(imageItems: stateTemp, isLoading: false);
  }

  // PixabayItem api 받아오기
  Future<Result<List<PixabayItem>>> getImageList(String query) async {
    final result = (await _searchUseCase.execute(query));
    return result;
  }

  // PixabayItem 업데이트
  Future<void> fetchImage(String query) async {
    await update((state) => state.copyWith(isLoading: true));

    await getImageList(query).then((value) async {
      value.when(
          success: (success) async {
            _eventController.add(PixabayEvent.showSnackBar('성공!!'));
            await update((state) => state.copyWith(isLoading: false, imageItems: success));
          },
          error: (error) async {
            _eventController.add(PixabayEvent.showSnackBar(error.toString()));
            await update((state) => state.copyWith(isLoading: false, imageItems: []));
          });
    });
  }
}

