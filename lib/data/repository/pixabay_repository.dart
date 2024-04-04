import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/pixabay_mapper.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';

abstract interface class PixabayRepository {
  Future<List<PixabayItem>> getImageSearch(String query);
}

class PixabayRepositoryImpl implements PixabayRepository {
  final _api = PixabayApi();
  @override
  Future<List<PixabayItem>> getImageSearch(String query)async {
    final dto = await _api.getImageResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toPixabayItem()).toList();
  }

}