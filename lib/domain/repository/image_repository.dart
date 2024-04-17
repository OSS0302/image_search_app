import 'package:image_search_app/core/result.dart';

import '../model/image_item.dart';

abstract interface class ImageRepository {
  Future<Result<List<ImageItem>>> getImageSearch(String query);
}