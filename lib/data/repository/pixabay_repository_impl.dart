import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mappper/pixabay_mapper.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayRepositoryImpl implements PixabayRepository {
  final _api = PixabayApi();

  @override
  Future<List<PixabayItem>> getPixabayItem(String query) async {
    final dto = await _api.getImageResult(query);
    if (dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toPixabayItem()).toList();
  }
}