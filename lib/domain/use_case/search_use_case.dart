import 'package:image_search_app/domain/repository/image_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class SearchUseCase {
  final ImageRepository _repository;

   SearchUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async{
    final result = await _repository.getImage(query);
    switch(result){

      case Success<List<ImageItem>>():
        result.data.toList();
      case Error<List<ImageItem>>():
        result.e.toString();
    }
    return result;
  }
}