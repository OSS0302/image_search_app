import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/main/pixabay_screen.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
import 'package:provider/provider.dart';

import 'data/repository/pixabay_repository.dart';
import 'di/di_setup.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<PixabayViewModel>(),
        child: PixabayScreen(),
      ),
    ),
  ],
);
