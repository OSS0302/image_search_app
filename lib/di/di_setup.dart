
import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/use_case/search_use_case.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
final getIt = GetIt.instance;
void diSetup(){
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerSingleton<SearchUseCase>(SearchUseCase(repository: ImageRepositoryImpl()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel(searchUseCase:getIt<SearchUseCase>() ));
}