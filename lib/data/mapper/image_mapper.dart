import 'package:image_search_app/data/dto/pixabay_dto.dart';
import 'package:image_search_app/domain/model/image_item.dart';

extension Tomodel on Hits {
  ImageItem toImageItem() {
    return ImageItem(
        imageUrl: previewURL ?? '' , id: id as int, tags: '');
  }
}