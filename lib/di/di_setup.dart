import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/domain/use_case/search_image_usecase.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
final getIt = GetIt.instance;
void diSetup() {
  getIt.registerSingleton<ImageItemRepository>(ImageItemRepositoryImpl());
  getIt.registerSingleton<SearchImageUseCase>(SearchImageUseCase(imageItemRepository: getIt<ImageItemRepository>()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel(searchImageUseCase: getIt<SearchImageUseCase>()));
}