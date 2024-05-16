import '../../data/model/image_item.dart';

class MainState {
  List<ImageItem> imageItem;
  bool isLoading = false;

//<editor-fold desc="Data Methods">
  MainState({
    required this.imageItem,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState &&
          runtimeType == other.runtimeType &&
          imageItem == other.imageItem &&
          isLoading == other.isLoading);

  @override
  int get hashCode => imageItem.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'MainState{' +
        ' imageItem: $imageItem,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  MainState copyWith({
    List<ImageItem>? imageItem,
    bool? isLoading,
  }) {
    return MainState(
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

  factory MainState.fromJson(Map<String, dynamic> json) {
    return MainState(
      imageItem: json['imageItem'] as List<ImageItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}
