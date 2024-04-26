import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mappper/pixabay_mapper.dart';
import 'package:image_search_app/domain/repository/pixabay_repository.dart';

import '../../core/result.dart';
import '../../domain/model/pixabay_item.dart';

class PixabayRepositoryImpl implements PixabayRepository {
  final _api = PixabayApi();

  @override
  Future<Result<List<PixabayItem>>> getPixabayItem(String query) async {
    final dto = await _api.getImageResult(query);
    if (dto.hits == null) {
      return Result.success([]);
    }
    return Result.success(dto.hits!.map((e) => e.toPixabayItem()).toList());
  }
}
