class VideoItem {
  final String pageURL;
  final String tags;
  final int id;

//<editor-fold desc="Data Methods">
  const VideoItem({
    required this.pageURL,
    required this.tags,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoItem &&
          runtimeType == other.runtimeType &&
          pageURL == other.pageURL &&
          tags == other.tags &&
          id == other.id);

  @override
  int get hashCode => pageURL.hashCode ^ tags.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'VideoItem{' +
        ' pageURL: $pageURL,' +
        ' tags: $tags,' +
        ' id: $id,' +
        '}';
  }

  VideoItem copyWith({
    String? pageURL,
    String? tags,
    int? id,
  }) {
    return VideoItem(
      pageURL: pageURL ?? this.pageURL,
      tags: tags ?? this.tags,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pageURL': this.pageURL,
      'tags': this.tags,
      'id': this.id,
    };
  }

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      pageURL: json['pageURL'] as String,
      tags: json['tags'] as String,
      id: json['id'] as int,
    );
  }

//</editor-fold>
}
