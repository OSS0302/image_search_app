import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/use_case/image_use_case.dart';
import 'package:image_search_app/presentation/main/home_view_model.dart';

import '../domain/repository/image_repository.dart';
final getIt = GetIt.instance;
void diSetUp(){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerSingleton<ImageUseCase>(ImageUseCase(repository: getIt<ImageRepository>()));
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel(imageUseCase: getIt<ImageUseCase>()));
}