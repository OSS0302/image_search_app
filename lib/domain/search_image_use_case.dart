import 'package:image_search_app/domain/model/image_item.dart';
import 'package:image_search_app/domain/repository/image_repository.dart';

import '../core/result.dart';

class SearchImageUseCase {
  final ImageRepository _repository;

   SearchImageUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async {
    final result = await _repository.getImageItem(query);
    switch(result){

      case Success<List<ImageItem>>():
        Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        Result.error(result.e);
    }
    return result;
  }
}