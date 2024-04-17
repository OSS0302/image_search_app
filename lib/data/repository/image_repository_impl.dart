import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mappper/image_mapper.dart';

import '../../core/result.dart';
import '../../domain/model/image_item.dart';
import '../../domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final _api = PixabayApi();

  @override
  Future<Result<List<ImageItem>>> getImageSearch(String query) async {
    try {
      final dto = await _api.getImageResult(query);
      if(dto.hits == null) {
        return const Result.success([]);
      }
      return Result.success(dto.hits!.map((e) => e.toImageItem()).toList());
    }catch(e){
      return Result.error(Exception(e.toString()));
    }


  }
}
