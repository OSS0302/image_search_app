import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/domain/use_case/image_use_case.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';

import '../domain/repository/pixabay_repository.dart';

final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerFactor<ImageUseCase>(() => ImageUseCase(repository: getIt<PixabayRepository>()));
  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(repository: getIt<PixabayRepository>()));
}
