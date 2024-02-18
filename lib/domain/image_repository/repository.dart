import '../model/image_item.dart';

abstract interface class PixabayRepository{
  Future<List<ImageItem>> getImageResult(String query);
}