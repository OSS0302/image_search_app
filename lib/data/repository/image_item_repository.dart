import 'package:image_search_app/domain/model/image_model.dart';

import '../../core/result.dart';

abstract interface class ImageItemRepository{
  Future<Result<List<ImageModel>>> getFatchImage(String query);
}