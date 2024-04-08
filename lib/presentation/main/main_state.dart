import '../../model/image_item.dart';

class MainState {
  bool isLoading = false;
  List<ImageItem> imageItems;

//<editor-fold desc="Data Methods">
  MainState({
    required this.isLoading,
    required this.imageItems,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          imageItems == other.imageItems);

  @override
  int get hashCode => isLoading.hashCode ^ imageItems.hashCode;

  @override
  String toString() {
    return 'MainState{' +
        ' isLoading: $isLoading,' +
        ' imageItems: $imageItems,' +
        '}';
  }

  MainState copyWith({
    bool? isLoading,
    List<ImageItem>? imageItems,
  }) {
    return MainState(
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

  factory MainState.fromJson(Map<String, dynamic> json) {
    return MainState(
      isLoading: json['isLoading'] as bool,
      imageItems: json['imageItems'] as List<ImageItem>,
    );
  }

//</editor-fold>
}