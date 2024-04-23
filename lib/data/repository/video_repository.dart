import 'package:image_search_app/data/model/video_item.dart';

abstract interface class VideoRepository {
  Future<List<VideoItem>> getVideoItem(String query);
}