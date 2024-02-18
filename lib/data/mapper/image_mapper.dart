import 'package:image_search_app/data/dto/pixabay_dto.dart';
import 'package:image_search_app/domain/model/image_item.dart';

extension DtoModel on Hits{
  ImageItem toImageItem(){
      return ImageItem(tags: '', imageUrl: previewURL ?? '');
  }
}