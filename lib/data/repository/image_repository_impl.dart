import 'package:image_search_app/data/data_source/piabay_api.dart';
import 'package:image_search_app/domain/model/image_item.dart';

import '../../domain/image_repository/repository.dart';

class PixabayItemRepository implements ImageRepository {
  final _api = PixabayApi();
  @override
  Future<List<ImageItem>> getImageResult(String query) async {
    final dto = _api.getImageResult(query);
    if()

    return dto.hits!.map((e) => e.toImageItem()).toList();
  }




}