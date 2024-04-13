import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';

final getIt = GetIt.instance;
void diSetup(){
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerSingleton<SearchUseCase>(SearchUseCase(repository: getIt<PixabayRepository>()));
   getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel( searchUseCase: getIt<SearchUseCase>()));

  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(repository: getIt<PixabayRepository>()));
}