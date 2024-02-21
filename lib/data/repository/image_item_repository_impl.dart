import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../../domain/repository/image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository {
  final _api = ImageApi();

  @override
  Future<List<ImageItem>> getImageResult(String query) async {
    final dto = await _api.getImageResult(query);
    if (dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }
}
class MockImageItemRepositoryImpl implements ImageItemRepository {
  @override
  Future<List<ImageItem>> getImageResult(String query) async {
   await Future.delayed(const Duration(seconds: 1));
    if(query == 'apple') {
      return [
        const ImageItem(imageUrl: "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg", tags: '', id: 0),
      ];
    }else {
      return [
        const ImageItem(imageUrl: "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg", tags: '', id: 1),
      ];
    }
  }
}
