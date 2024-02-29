import '../../core/result.dart';
import '../../domain/model/image_item.dart';
import '../../domain/repository/image_item_repository.dart';

class MockImageItemRepositoryImpl implements ImageItemRepository {
  @override
  Future<Result<List<ImageItem>>> getImageResult(String query)  async {
    Future.delayed(Duration(seconds: 1));
    if (query == 'apple') {
      return const Result.success([
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg",
            tags: '', id: 12),
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
            tags: '', id: 2),
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
            tags: '', id: 3),
      ]);
    } else {
      return Result.success([
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2015/03/14/19/45/suit-673697_150.jpg",
            tags: '', id: 4),
        ImageItem(
            imageUrl:
            "https://cdn.pixabay.com/photo/2019/09/21/09/07/banana-4493420_150.jpg",
            tags: '', id: 5),
      ]);
    }
  }
}