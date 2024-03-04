
import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/image_item_mapper.dart';
import 'package:image_search_app/data/model/image_model.dart';

import 'image_item_repository.dart';

class ImageItemRepositoryImpl implements ImageItemRepository{
  final _api = PixabayApi();
  @override
  Future<List<ImageModel>> getFatchImage(String query) async{
   final dto = await _api.getImageResult(query);
   if(dto.hits == null){
     return [];
   }
   return dto.hits!.map((e) => e.toImageModel()).toList();
  }

}