import '../../data/model/pixabay_item.dart';

class PixabayState {
   bool isLoading = false;
  final List<ImageItem> imageItems;

//<editor-fold desc="Data Methods">
  PixabayState({
    required this.isLoading,
    required this.imageItems,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixabayState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          imageItems == other.imageItems);

  @override
  int get hashCode => isLoading.hashCode ^ imageItems.hashCode;

  @override
  String toString() {
    return 'PixabayState{' +
        ' isLoading: $isLoading,' +
        ' imageItems: $imageItems,' +
        '}';
  }

  PixabayState copyWith({
    bool? isLoading,
    List<ImageItem>? imageItems,
  }) {
    return PixabayState(
      isLoading: isLoading ?? this.isLoading,
      imageItems: imageItems ?? this.imageItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLoading': this.isLoading,
      'imageItems': this.imageItems,
    };
  }

  factory PixabayState.fromMap(Map<String, dynamic> json) {
    return PixabayState(
      isLoading: json['isLoading'] as bool,
      imageItems: json['imageItems'] as List<ImageItem>,
    );
  }

//</editor-fold>
}