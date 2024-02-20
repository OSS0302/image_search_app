import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';

GetIt getIt = GetIt.instance;

void diSetup(){
  getIt.registerSingleton<ImageItemRepository>(ImageItemRepositoryImpl());
  
  getIt.registerFactory(() => MainViewModel(repository: ImageItemRepositoryImpl()));
}