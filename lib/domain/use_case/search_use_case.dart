import 'package:image_search_app/domain/repository/image_item_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class SearchImageUseCase {
  final ImageItemRepository _imageItemRepository;

  const SearchImageUseCase({
    required ImageItemRepository imageItemRepository,
  }) : _imageItemRepository = imageItemRepository;

  Future<Result<List<ImageItem>>> execute (String query ) async {
    final result = await _imageItemRepository.getSearchImage(query);
    switch(result){
      case Success<List<ImageItem>>():
        return Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        return Result.error(result.e);
      case Loading<List<ImageItem>>():
    }
    return result;
  }
}