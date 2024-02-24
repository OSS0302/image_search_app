import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_items.dart';

import '../../domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final _api = PixabayApi();

  @override
  Future<List<ImageItems>> getImageItems(String query) async {
    final dto = await _api.getImageData(query);
    if (dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toImageItems()).toList();
  }
}


class MockImageItemRepository implements ImageRepository {
  @override
  Future<List<ImageItems>> getImageItems(String query) async {
    await Future.delayed(const Duration(seconds: 1));

    if (query == 'apple') {
      return [
        ImageItems(
            imageUrl:
            "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg",
            tags: '', id: 12),
        ImageItems(
            imageUrl:
            "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
            tags: '', id: 2),
        ImageItems(
            imageUrl:
            "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
            tags: '', id: 3),
      ];
    } else {
      return [
        ImageItems(
            imageUrl:
            "https://cdn.pixabay.com/photo/2015/03/14/19/45/suit-673697_150.jpg",
            tags: '', id: 4),
        ImageItems(
            imageUrl:
            "https://cdn.pixabay.com/photo/2019/09/21/09/07/banana-4493420_150.jpg",
            tags: '', id: 5),
      ];
    }
  }
}