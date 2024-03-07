import 'package:go_router/go_router.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/domain/model/image_model.dart';
import 'package:image_search_app/ui/detail/detail_screen.dart';
import 'package:image_search_app/ui/main/main_screen.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<MainViewModel>(),
        child: MainScreen(),
      ),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final imageModel = state.extra as ImageModel;
        return DetailScreen(imageModel: imageModel);
      },
    ),
  ],
);
