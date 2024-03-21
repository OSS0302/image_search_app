import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent<T> with _$HomeEvent<T> {
  const factory HomeEvent.showSnackBar(String message) = ShowSnackBar;
  const factory HomeEvent.showDialog(String message) = ShowDialog;
}