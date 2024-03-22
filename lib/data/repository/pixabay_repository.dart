import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mappper/pixabay_mapper.dart';

import '../model/pixabay_item.dart';

abstract interface class PixabayRepository {
  Future<List<ImageItem>> getImageItem(String query);
}

class PixabayRepositoryImpl implements PixabayRepository {
  final _api = PixabayApi();

  @override
  Future<List<ImageItem>> getImageItem(String query) async{
    final dto = await _api.getSearchResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }

}