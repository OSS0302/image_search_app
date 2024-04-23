import 'package:image_search_app/data/data_source/video_api.dart';
import 'package:image_search_app/data/mapper/video_mapper.dart';
import 'package:image_search_app/data/model/video_item.dart';
import 'package:image_search_app/data/repository/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final _api = VideoApi();


  @override
  Future<List<VideoItem>> getVideoItem(String query) async{
    final dto = await _api.getVideoResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toViedoItem()).toList();
  }

}