import 'package:image_search_app/data/dto/image_dto.dart';

import '../../domain/model/image_item.dart';


extension DtoToModel on Hits {
  ImageItem toImageItem() {
    return ImageItem(
      imageUrl: previewURL ?? '이미지가 없습니다 다른 이미지를 검색해주세요',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
