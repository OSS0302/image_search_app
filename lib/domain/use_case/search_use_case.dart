import 'package:image_search_app/domain/reposiotory/image_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class SearchUseCase {
  final ImageRepository _imageRepository;

   SearchUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  Future<Result<List<ImageItem>>> execute (String query) async{
    final result = await _imageRepository.getImageResult(query);

    switch(result){

      case Success<List<ImageItem>>():
       Result.success(_imageRepository.getImageResult(query));
      case Error<List<ImageItem>>():
       Result.error(result.e);
      case Loading<List<ImageItem>>():
    }
    return result;
  }
 }