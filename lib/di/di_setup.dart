import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';

import '../domain/repository/image_item_repository.dart';

GetIt getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<ImageItemRepository>(ImageItemRepositoryImpl());
  getIt.registerFactory<MainViewModel>(() => MainViewModel(repository: getIt<ImageItemRepository>()));
}