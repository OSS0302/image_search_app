import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../../core/result.dart';

class SearchUseCase {
  final ImageRepository  _repository;

  const SearchUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async {
    final result = await _repository.getImageSearch(query);
    switch(result){

      case Success<List<ImageItem>>():
        Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}
