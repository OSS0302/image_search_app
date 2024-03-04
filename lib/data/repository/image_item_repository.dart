import 'package:image_search_app/data/model/image_model.dart';

abstract interface class ImageItemRepository{
  Future<List<ImageModel>> getFatchImage(String query);
}