import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class ImageUseCase {
  final ImageRepository _repository;

  const ImageUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async{
    final result = await _repository.getfetchImage(query);
    switch(result) {

      case Success<List<ImageItem>>():
        Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}