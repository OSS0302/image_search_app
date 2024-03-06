import 'package:image_search_app/domain/model/image_model.dart';
import '../../core/result.dart';
import '../../data/repository/image_item_repository.dart';

class SearchImageUseCase{
  final ImageItemRepository _imageItemRepository;
  const SearchImageUseCase({
    required ImageItemRepository imageItemRepository,
  }) : _imageItemRepository = imageItemRepository;

  Future<Result<List<ImageModel>>> execute(String query) async{
    final result = await _imageItemRepository.getFatchImage(query);

    switch(result){
      case Success<List<ImageModel>>():
        return Result.success(result.data.toList());
      case Error<List<ImageModel>>():
        return Result.error(result.e);
      case loading<List<ImageModel>>():
    }
    return result;
  }


}