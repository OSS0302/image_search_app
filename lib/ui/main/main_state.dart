import '../../data/model/pixabay_item.dart';

class MainState {
  bool isLoading = false;
  List<PixabayItem> pixabayItem;

//<editor-fold desc="Data Methods">
  MainState({
    required this.isLoading,
    required List<PixabayItem> pixabayItem,
  }) : pixabayItem = pixabayItem;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          pixabayItem == other.pixabayItem);

  @override
  int get hashCode => isLoading.hashCode ^ pixabayItem.hashCode;

  @override
  String toString() {
    return 'MainState{' +
        ' isLoading: $isLoading,' +
        ' _pixabayItem: $pixabayItem,' +
        '}';
  }

  MainState copyWith({
    bool? isLoading,
    List<PixabayItem>? pixabayItem,
  }) {
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      pixabayItem: pixabayItem ?? this.pixabayItem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': this.isLoading,
      '_pixabayItem': this.pixabayItem,
    };
  }

  factory MainState.fromJson(Map<String, dynamic> json) {
    return MainState(
      isLoading: json['isLoading'] as bool,
      pixabayItem: json['_pixabayItem'] as List<PixabayItem>,
    );
  }

//</editor-fold>
}