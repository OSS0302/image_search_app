import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/domain/repository/pixabay_repository.dart';

import '../../data/core/result.dart';

class SearchImageUseCase {
  final PixabayRepository _repository;

  const SearchImageUseCase({
    required PixabayRepository repository,
  }) : _repository = repository;

  Future<Result<List<PixabayItem>>> execute(String query) async {
    final result = await _repository.getImageSearch(query);
    switch(result){
      case Success<List<PixabayItem>>():
       Result.success(result.data);
      case Error<List<PixabayItem>>():
       Result.error(result.e);
    }
    return result;
  }

}