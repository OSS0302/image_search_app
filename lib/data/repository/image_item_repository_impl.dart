import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/data/model/image_item.dart';

import 'image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository {
  final _api = PixabayApi();
  @override
  Future<List<ImageItem>> getImageData(String query) async{
    final dto = await _api.getImageResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }
}
class MockImageItemRepository implements ImageItemRepository {
  @override
  Future<List<ImageItem>> getImageData(String query) async{
    Future.delayed(const Duration(seconds: 1));

    return [
      ImageItem(imageUrl:  "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg", tags: '', id: 1),
      ImageItem(imageUrl:  "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg", tags: '', id: 2),
      ImageItem(imageUrl:  "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg", tags: '', id: 3),
    ];
  }


}