import 'package:go_router/go_router.dart';
import 'package:image_search_app/ui/pixabay/pixabay_screen.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';

import 'di/di_setup.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<PixabayViewModel>(),
        child: const PixabayScreen(),
      ),
    ),
  ],
);
