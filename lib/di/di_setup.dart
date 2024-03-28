import 'package:get_it/get_it.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';

import '../domain/reposiotory/image_repository.dart';
final getIt = GetIt.instance;

void diSetUp(){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerFactory<MainViewModel>(() => MainViewModel(repository: getIt<ImageRepository>()));
}