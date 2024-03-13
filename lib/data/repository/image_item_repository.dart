import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';

import '../model/image_item.dart';

abstract interface class ImageItemRepository {
  Future<List<ImageItem>> getSearchImage(String query);
}

class ImageItemRepositoryImpl implements ImageItemRepository {
  final _api = PixabayApi();

  @override
  Future<List<ImageItem>> getSearchImage(String query) async {
    final dto = await _api.getImageResult(query);
    if (dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }
}

class MockImageItemRepositoryImpl implements ImageItemRepository {
  @override
  Future<List<ImageItem>> getSearchImage(String query) async{
   await Future.delayed(const Duration(seconds: 2));
    if (query == 'apple') {
      return[
        ImageItem(imageUrl: "https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537_150.jpg", tags:  '', id: 1)
      ];
    }else{
      return[
        ImageItem(imageUrl: "https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537_150.jpg", tags:  '', id: 2)
      ];
    }
  }
}
