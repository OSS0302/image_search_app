import '../../data/model/pixabay_item.dart';

class PixabayState {
  List<PixabayItem> imageItem;
  bool isLoading = false;

//<editor-fold desc="Data Methods">
  PixabayState({
    required this.imageItem,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixabayState &&
          runtimeType == other.runtimeType &&
          imageItem == other.imageItem &&
          isLoading == other.isLoading);

  @override
  int get hashCode => imageItem.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'PixabayState{' +
        ' imageItem: $imageItem,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  PixabayState copyWith({
    List<PixabayItem>? imageItem,
    bool? isLoading,
  }) {
    return PixabayState(
      imageItem: imageItem ?? this.imageItem,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageItem': this.imageItem,
      'isLoading': this.isLoading,
    };
  }

  factory PixabayState.fromMap(Map<String, dynamic> json) {
    return PixabayState(
      imageItem: json['imageItem'] as List<PixabayItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}