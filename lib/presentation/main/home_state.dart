import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../domain/model/image_item.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<ImageItem> imageItems,
    @Default(false) bool isLoading,

  }) = _MainState;

  factory HomeState.fromJson(Map<String, Object?> json) => _$HomeStateFromJson(json);
}