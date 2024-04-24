import '../../data/model/image_item.dart';

class ImageState {
  List<ImageItem> imageItems;
  bool isLoading = false;

//<editor-fold desc="Data Methods">
  ImageState({
    required this.imageItems,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageState &&
          runtimeType == other.runtimeType &&
          imageItems == other.imageItems &&
          isLoading == other.isLoading);

  @override
  int get hashCode => imageItems.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'ImageState{' +
        ' imageItems: $imageItems,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  ImageState copyWith({
    List<ImageItem>? imageItems,
    bool? isLoading,
  }) {
    return ImageState(
      imageItems: imageItems ?? this.imageItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageItems': this.imageItems,
      'isLoading': this.isLoading,
    };
  }

  factory ImageState.fromJson(Map<String, dynamic> json) {
    return ImageState(
      imageItems: json['imageItems'] as List<ImageItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}