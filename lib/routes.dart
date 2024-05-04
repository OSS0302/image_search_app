import 'package:go_router/go_router.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/presentation/detail/detail_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<PixabayViewModel>(),
        child: PixabayScreen(),
      ),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
      final pixabayItem = state.extra as PixabayItem;
      return DetailScreen(pixabayItem: pixabayItem);
      },
    ),
  ],
);
