import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../../domain/repository/image_repository.dart';

class ImageRespositoryImpl implements ImageRepository {
  final _api = ImageApi();
  @override
  Future<List<ImageItem>> getImageItem(String query) async {
    final dto = await _api.getImageResult(query);
    if(dto.hits == null ){
      return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }

}
