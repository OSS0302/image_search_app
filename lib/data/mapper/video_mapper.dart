import 'package:image_search_app/data/dto/video_dto.dart';
import 'package:image_search_app/data/model/video_item.dart';

extension DtoToModel on Hits {
  VideoItem toViedoItem() {
    return VideoItem(
      pageURL: pageURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
