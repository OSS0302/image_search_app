import '../../data/model/image_item.dart';

class HomeState {
  bool isLoading = false;
  List<ImageItem> imageItem;

//<editor-fold desc="Data Methods">
  HomeState({
    required this.isLoading,
    required this.imageItem,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          imageItem == other.imageItem);

  @override
  int get hashCode => isLoading.hashCode ^ imageItem.hashCode;

  @override
  String toString() {
    return 'HomeState{' +
        ' isLoading: $isLoading,' +
        ' imageItem: $imageItem,' +
        '}';
  }

  HomeState copyWith({
    bool? isLoading,
    List<ImageItem>? imageItem,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      imageItem: imageItem ?? this.imageItem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': this.isLoading,
      'imageItem': this.imageItem,
    };
  }

  factory HomeState.fromJson(Map<String, dynamic> json) {
    return HomeState(
      isLoading: json['isLoading'] as bool,
      imageItem: json['imageItem'] as List<ImageItem>,
    );
  }

//</editor-fold>
}