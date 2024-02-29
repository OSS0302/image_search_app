import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../../core/result.dart';
import '../../domain/repository/image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository {
  final _api = PixabayApi();

  @override
  Future<Result<List<ImageItem>>> getImageResult(String query) async {
    final dto = await _api.getImageResult(query);
    if (dto.hits == null) {
      return Result.success([]);
    }
    return Result.success(dto.hits!.map((e) => e.toImageItem()).toList());
  }
}

