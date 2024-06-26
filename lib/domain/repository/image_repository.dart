import '../../core/result.dart';
import '../model/image_item.dart';

abstract interface class ImageRepository {
  Future<Result<List<ImageItem>>> getImageItems(String query);
}