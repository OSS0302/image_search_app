import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/model/image_item.dart';

abstract interface class ImageRepository {
  Future<Result<List<ImageItem>>> getImageSearch(String query);
}