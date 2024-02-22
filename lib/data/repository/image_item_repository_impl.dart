import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_item.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository{
  final _api = PixabayApi();
  @override
  Future<List<ImageItem>> getImageData(String query) async {
    final dto = await _api.getResult(query);
    if(dto.hits == null ){
        return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }

}