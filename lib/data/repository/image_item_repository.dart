import '../../core/result.dart';
import '../model/image_item.dart';

abstract interface class ImageItemRepository {
  Future<Result<List<ImageItem>>> getImageData(String query);
}