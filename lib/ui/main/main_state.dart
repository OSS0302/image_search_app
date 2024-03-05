import 'package:image_search_app/data/model/image_model.dart';

class MainState{
  final List<ImageModel> imageItems;

  final bool isLoading;

//<editor-fold desc="Data Methods">
  const MainState({
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
    List<ImageModel>? imageItems,
    bool? isLoading,
  }) {
    return MainState(
      imageItems: imageItems ?? this.imageItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageItems': this.imageItems,
      'isLoading': this.isLoading,
    };
  }

  factory MainState.fromMap(Map<String, dynamic> map) {
    return MainState(
      imageItems: map['imageItems'] as List<ImageModel>,
      isLoading: map['isLoading'] as bool,
    );
  }

//</editor-fold>
}