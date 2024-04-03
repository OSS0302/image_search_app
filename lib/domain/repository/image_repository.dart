import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

abstract interface class ImageRepository {
  Future<Result<List<ImageItem>>> getImageSearch(String query);
}

