import '../../data/model/image_item.dart';

class ImageState {
  List<ImageItem> imageItem;
  bool isLoadidng = false;

//<editor-fold desc="Data Methods">
  ImageState({
    required this.imageItem,
    required this.isLoadidng,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageState &&
          runtimeType == other.runtimeType &&
          imageItem == other.imageItem &&
          isLoadidng == other.isLoadidng);

  @override
  int get hashCode => imageItem.hashCode ^ isLoadidng.hashCode;

  @override
  String toString() {
    return 'ImageState{' +
        ' imageItem: $imageItem,' +
        ' isLoadidng: $isLoadidng,' +
        '}';
  }

  ImageState copyWith({
    List<ImageItem>? imageItem,
    bool? isLoadidng,
  }) {
    return ImageState(
      imageItem: imageItem ?? this.imageItem,
      isLoadidng: isLoadidng ?? this.isLoadidng,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageItem': this.imageItem,
      'isLoadidng': this.isLoadidng,
    };
  }

  factory ImageState.fromJson(Map<String, dynamic> json) {
    return ImageState(
      imageItem: json['imageItem'] as List<ImageItem>,
      isLoadidng: json['isLoadidng'] as bool,
    );
  }

//</editor-fold>
}