class ImageItem {
  final String imageUrl;
  final String userImageURL;
  final String  tags;
  final int id;

//<editor-fold desc="Data Methods">


  const ImageItem({
    required this.imageUrl,
    required this.userImageURL,
    required this.tags,
    required this.id,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ImageItem &&
              runtimeType == other.runtimeType &&
              imageUrl == other.imageUrl &&
              userImageURL == other.userImageURL &&
              tags == other.tags &&
              id == other.id
          );


  @override
  int get hashCode =>
      imageUrl.hashCode ^
      userImageURL.hashCode ^
      tags.hashCode ^
      id.hashCode;


  @override
  String toString() {
    return 'ImageItem{' +
        ' imageUrl: $imageUrl,' +
        ' userImageURL: $userImageURL,' +
        ' tags: $tags,' +
        ' id: $id,' +
        '}';
  }


  ImageItem copyWith({
    String? imageUrl,
    String? userImageURL,
    String? tags,
    int? id,
  }) {
    return ImageItem(
      imageUrl: imageUrl ?? this.imageUrl,
      userImageURL: userImageURL ?? this.userImageURL,
      tags: tags ?? this.tags,
      id: id ?? this.id,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'userImageURL': this.userImageURL,
      'tags': this.tags,
      'id': this.id,
    };
  }

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      imageUrl: json['imageUrl'] as String,
      userImageURL: json['userImageURL'] as String,
      tags: json['tags'] as String,
      id: json['id'] as int,
    );
  }


//</editor-fold>
}