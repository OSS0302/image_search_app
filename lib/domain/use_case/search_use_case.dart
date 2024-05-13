
import '../../data/core/result.dart';
import '../model/pixabay_item.dart';
import '../repository/pixabay_repository.dart';

class SearchUseCase {
  final PixabayRepository _repository;

  const SearchUseCase({
    required PixabayRepository repository,
  }) : _repository = repository;

  Future<Result<List<PixabayItem>>> execute(String query) async {
    final result = await _repository.getPixabayItem(query);
    switch (result) {
      case Success<List<PixabayItem>>():
        Result.success(result.data.toString());
      case Error<List<PixabayItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}
