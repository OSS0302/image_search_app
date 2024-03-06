
import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_item_mapper.dart';
import 'package:image_search_app/domain/model/image_model.dart';

import '../../core/result.dart';
import 'image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository{
  final _api = PixabayApi();
  @override
  Future<Result<List<ImageModel>>> getFatchImage(String query) async{
    try {
      final dto = await _api.getImageResult(query);
      if(dto.hits == null){
        return Result.success([]);
      }
      return Result.success(dto.hits!.map((e) => e.toImageModel()).toList());
      
    }catch (e) {
      return Result.error(Exception(e.toString()));
    }

  }

}