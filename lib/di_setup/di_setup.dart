import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/presentation/main/image_view_model.dart';
final getIt = GetIt.instance;
void diSetup() {
  getIt.registerSingleton<ImageItemRepository>(ImageItemRepositoryImpl());
  getIt.registerFactory<ImageViewModel>(() => ImageViewModel(repository: ImageItemRepositoryImpl()) );
}