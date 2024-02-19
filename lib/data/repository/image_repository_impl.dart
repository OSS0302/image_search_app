import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/image_repository/repository.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../data_source/piabay_api.dart';

// 실제 api 데이터
class PixabayImageItemRepositoryImpl implements ImageItemRepository {
  final _api = PixabayApi();

  @override
  Future<List<ImageItem>> getImageResult(String query) async {
    final dto = await _api.getImagesResult(query);

    if (dto.hits == null) {
      return [];
    }

    return dto.hits!.map((e) => e.toImageItem()).toList();
  }

}
  class MockImageItemRepository implements ImageItemRepository {
  @override
  Future<List<ImageItem>> getImageResult(String query) async {
    await Future.delayed(const Duration(seconds: 2));
    if (query == 'apple') {
      return [
        ImageItem(
          tags: '',
          imageUrl:
              "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
        ),
        ImageItem(
          tags: '',
          imageUrl:
              "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
        ),
        ImageItem(
          tags: '',
          imageUrl:
              "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
        ),
      ];
    } else {
      return [
        ImageItem(tags: '', imageUrl:  "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",),
      ];
    }
  }
}
