import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/image_repository/repository.dart';
import 'package:image_search_app/ui/main_view_model.dart';

final getIt  = GetIt.instance;

void disetup(){
  getIt.registerSingleton<ImageItemRepository>(PixabayImageItemRepositoryImpl());

  getIt.registerFactory<MainViewModel>(() => MainViewModel(repository: PixabayImageItemRepositoryImpl));
}