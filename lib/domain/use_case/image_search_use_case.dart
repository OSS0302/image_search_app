import 'package:image_search_app/domain/repository/image_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class ImageSearchUseCase {
  final ImageRepository _imageRepository;

  const ImageSearchUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;


  Future<Result<List<ImageItem>>> execute(String query) async {
    final result = await _imageRepository.getImageItems(query);
    switch(result) {

      case Success<List<ImageItem>>():
        return Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        return Result.error(result.e);
      case Loading<List<ImageItem>>():
    }
    return result;
  }
}
