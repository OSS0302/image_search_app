import '../../data/model/image_item.dart';

class MainState {
  List<ImageItem> imageItems;
  bool isLoading = false;

//<editor-fold desc="Data Methods">
  MainState({
    required this.isLoading,
    required List<ImageItem> imageItems,
  }) : imageItems = imageItems;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState &&
          runtimeType == other.runtimeType &&
          imageItems == other.imageItems &&
          isLoading == other.isLoading);

  @override
  int get hashCode => imageItems.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'MainState{' +
        ' _imageItems: $imageItems,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  MainState copyWith({
    List<ImageItem>? imageItems,
    bool? isLoading,
  }) {
    return MainState(
      imageItems: imageItems ?? this.imageItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_imageItems': this.imageItems,
      'isLoading': this.isLoading,
    };
  }

  factory MainState.fromJson(Map<String, dynamic> json) {
    return MainState(
      imageItems: json['_imageItems'] as List<ImageItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}