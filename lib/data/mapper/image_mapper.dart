import 'package:image_search_app/data/dto/image_dto.dart';
import 'package:image_search_app/data/model/image_item.dart';

extension DtoToModel on Hits {
  ImageItem toImageItem() {
    return ImageItem(
      imageUrl: previewURL ?? '',
      userImageURL: userImageURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
