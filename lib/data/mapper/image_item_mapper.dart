import 'package:image_search_app/data/dto/image_dto.dart';
import 'package:image_search_app/data/model/image_model.dart';

extension DtoToModel on Hits {
  ImageModel toImageModel() {
    return ImageModel(
      imageUrl: previewURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
