class ImageModel{
  String imageUrl;
  String tags;
  int id;

//<editor-fold desc="Data Methods">
  ImageModel({
    required this.imageUrl,
    required this.tags,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageModel &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl &&
          tags == other.tags &&
          id == other.id);

  @override
  int get hashCode => imageUrl.hashCode ^ tags.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'ImageModel{' +
        ' imageUrl: $imageUrl,' +
        ' tags: $tags,' +
        ' id: $id,' +
        '}';
  }

  ImageModel copyWith({
    String? imageUrl,
    String? tags,
    int? id,
  }) {
    return ImageModel(
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'tags': this.tags,
      'id': this.id,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      imageUrl: map['imageUrl'] as String,
      tags: map['tags'] as String,
      id: map['id'] as int,
    );
  }

//</editor-fold>
}