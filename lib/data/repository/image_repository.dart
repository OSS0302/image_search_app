import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';

import '../../model/image_item.dart';

abstract interface class ImageRepository {
  Future<List<ImageItem>> getImage(String query);
}

class ImageRepositoryImpl implements ImageRepository {
  final _api = ImageApi();
  @override
  Future<List<ImageItem>> getImage(String query) async{
    final dto = await _api.getImageResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) =>  e.toImageItem()).toList();
  }

}