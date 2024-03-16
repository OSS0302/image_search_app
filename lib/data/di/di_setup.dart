import 'package:get_it/get_it.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';
import 'package:image_search_app/domain/use_case/search_use_case.dart';

import '../../presentation/main/main_view_model.dart';
import '../repository/image_item_repository_impl.dart';

final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<ImageItemRepository>(ImageItemRepositoryImpl());
  getIt.registerSingleton<SearchImageUseCase>(SearchImageUseCase(imageItemRepository: getIt<ImageItemRepository>()));
  
  getIt.registerFactory<MainViewModel>(() => MainViewModel(repository: repository))
  
}