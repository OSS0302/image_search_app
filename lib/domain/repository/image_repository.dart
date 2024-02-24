import 'package:image_search_app/domain/model/image_items.dart';

abstract interface class ImageRepository {
  Future<List<ImageItems>> getImageItems(String query);
}