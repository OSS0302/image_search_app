import 'package:image_search_app/data/dto/image_dto.dart';
import 'package:image_search_app/domain/model/image_items.dart';

extension DtoToModel on Hits{
  ImageItems toImageItems(){
    return ImageItems(imageUrl: previewURL ?? '', tags: tags ?? '', id: id as int);
  }
}