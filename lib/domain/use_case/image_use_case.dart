import 'package:image_search_app/domain/repository/image_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class ImageUseCase {
  final ImageRepository _imageRepository;

  const ImageUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;


  Future<Result<List<ImageItem>>> execute(String query) async{
    final result = await _imageRepository.getSearchImage(query);
    switch(result){

      case Success<List<ImageItem>>():
       return Result.success(result.data.toList());
      case Error<List<ImageItem>>():
     return  Result.error(result.e);
      case Loading<List<ImageItem>>():
        // TODO: Handle this case.
    }
    return result;
  }
}