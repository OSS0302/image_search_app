import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../../domain/repository/image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository {
  final _api = PixabayApi();

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
  Future<List<ImageItem>> getImageResult(String query)  async {
    Future.delayed(Duration(seconds: 1));
    if (query == 'apple') {
      return [
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg",
            tags: '', id: 12),
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
            tags: '', id: 2),
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
            tags: '', id: 3),
      ];
    } else {
      return [
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2015/03/14/19/45/suit-673697_150.jpg",
            tags: '', id: 4),
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2019/09/21/09/07/banana-4493420_150.jpg",
            tags: '', id: 5),
      ];
  }
}
}
