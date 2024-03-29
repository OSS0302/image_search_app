import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';

final getIt = GetIt.instance;

void diSetUp(){
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(pixabayRepository: getIt<PixabayRepository>()));
}