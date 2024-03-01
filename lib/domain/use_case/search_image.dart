import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/domain/repository/star_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class SearchImageUseCase {
  final ImageItemRepository _imageItemRepository;
  final StarRepository _starRepository;

  const SearchImageUseCase({
    required ImageItemRepository imageItemRepository,
    required StarRepository starRepository,
  })  : _imageItemRepository = imageItemRepository,
        _starRepository = starRepository;

  Future<Result<List<ImageItem>>> execute(String query) async {
    final result = await _imageItemRepository.getImageResult(query);
    switch (result) {
      case Success<List<ImageItem>>():
        return Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        return Result.success(_starRepository
            .getStar()
            .map(
                (e) => ImageItem(imageUrl: e.imageUrl, tags: e.title, id: e.id))
            .toList());
      case Loading<List<ImageItem>>():
      // TODO: Handle this case.
    }
    return result;
  }
}
