import 'package:image_search_app/data/repository/image_repository_imp.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class ImageSearchUseCase {
  final ImageRepository _repository;

  ImageSearchUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async {
    final result = await _repository.getImageSearch(query);

    switch (result) {
      case Success<List<ImageItem>>():
        Result.success(result.data);
      case Error<List<ImageItem>>():
        Result.error(result.e);
    }
    return result;
  }
}
