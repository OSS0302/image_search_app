import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_item.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository {
  final _api = ImageApi();

  @override
  Future<List<ImageItem>> getImageItems(String query) async {
    final dto = await _api.getImageData(query);
      if (dto.hits == null) {
        return [];
      }
      return dto.hits!.map((e) => e.toImageItem()).toList();
    }
  }
class MockImageItemRepository implements ImageItemRepository{
  @override
  Future<List<ImageItem>> getImageItems(String query)  async{
   await Future.delayed(const Duration(seconds: 1));
    if(query == 'apple'){
      return[
        const ImageItem(imageUrl: "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg", tags: ''),
      ];

    }else{
      return[
        const ImageItem(imageUrl: '이미지가 없습니다.', tags: ''),
      ];
    }
  }

}