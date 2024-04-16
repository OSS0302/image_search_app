import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/main/home_view_model.dart';
final getIt = GetIt.instance;
void diSetUp(){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel(repository: getIt<ImageRepository>()));
}