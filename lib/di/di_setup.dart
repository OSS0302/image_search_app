import 'package:get_it/get_it.dart';
import 'package:image_search_app/domain/repository/pixabay_repository.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/domain/use_case/image_search_use_case.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
 getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
 getIt.registerSingleton<ImageSearchUseCase>(ImageSearchUseCase(repository: getIt<PixabayRepository>()));
 getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(searchUseCase: getIt<ImageSearchUseCase>()));
}