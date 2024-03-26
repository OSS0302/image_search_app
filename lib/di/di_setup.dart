import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/use_case/image_search_use_case.dart';

import '../domain/repository/image_repository.dart';
import '../presentation/main/main_view_model.dart';
final getIt = GetIt.instance;

void diSetUp (){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerFactory<MainViewModel>(() => MainViewModel(imageSearchUseCase: getIt<ImageSearchUseCase>()));
}