import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_search_app/domain/use_case/search_image_usecase.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';

import '../data/repository/pixabay_repository_impl.dart';
import '../domain/repository/pixabay_repository.dart';

final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerSingleton<SearchImageUseCase>(SearchImageUseCase(repository: getIt<PixabayRepository>()));
  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(imageUseCase: getIt<SearchImageUseCase>()));
}