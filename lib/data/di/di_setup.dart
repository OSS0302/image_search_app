import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../ui/main/home_view_model.dart';
final getIt = GetIt.instance;

void diSetUp(){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  
  getIt.registerFactory(() => HomeViewModel(repository: getIt<ImageRepository>()));
}