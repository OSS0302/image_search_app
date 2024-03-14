import '../../data/model/image_item.dart';

class MainState{
  final List<ImageItem> imageItems;

  final bool isLoading;

  MainState({
    required this.imageItems,
    required this.isLoading,
  });

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
        ' imageItems: $imageItems,' +
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

  Map<String, dynamic> tojson() {
    return {
      'imageItems': this.imageItems,
      'isLoading': this.isLoading,
    };
  }

  factory MainState.fromMap(Map<String, dynamic> json) {
    return MainState(
      imageItems: json['imageItems'] as List<ImageItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

}
