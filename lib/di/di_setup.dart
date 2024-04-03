
import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
final getIt = GetIt.instance;
void diSetup(){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerFactory<MainViewModel>(() => MainViewModel(repository: getIt<ImageRepository>()));
}