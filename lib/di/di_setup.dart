import 'package:get_it/get_it.dart';
import 'package:image_search_app/domain/repository/pixabay_repository.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/domain/use_case/image_use_case.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
final getIt = GetIt.instance;
void diSetup() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerSingleton<ImageUseCase>(ImageUseCase(repository: getIt<PixabayRepository>()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel( imageUseCase: getIt<ImageUseCase>()));
}