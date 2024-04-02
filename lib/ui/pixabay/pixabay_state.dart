import '../../data/model/pixabay_item.dart';

class PixabayState {

  bool isLoading = false;
  List<PixabayItem> imageItems;

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
    List<PixabayItem>? imageItems,
  }) {
    return PixabayState(
      isLoading: isLoading ?? this.isLoading,
      imageItems: imageItems ?? this.imageItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': this.isLoading,
      'imageItems': this.imageItems,
    };
  }

  factory PixabayState.fromJson(Map<String, dynamic> json) {
    return PixabayState(
      isLoading: json['isLoading'] as bool,
      imageItems: json['imageItems'] as List<PixabayItem>,
    );
  }

//</editor-fold>
}