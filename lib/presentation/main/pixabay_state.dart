import '../../data/model/pixabay_item.dart';

class PixabayState {
  List<PixabayItem> imageItems;
  bool isLoading = false;

//<editor-fold desc="Data Methods">
  PixabayState({
    required this.imageItems,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixabayState &&
          runtimeType == other.runtimeType &&
          imageItems == other.imageItems &&
          isLoading == other.isLoading);

  @override
  int get hashCode => imageItems.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'PixabayState{' +
        ' imageItems: $imageItems,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  PixabayState copyWith({
    List<PixabayItem>? imageItems,
    bool? isLoading,
  }) {
    return PixabayState(
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

  factory PixabayState.fromJson(Map<String, dynamic> json) {
    return PixabayState(
      imageItems: json['imageItems'] as List<PixabayItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}