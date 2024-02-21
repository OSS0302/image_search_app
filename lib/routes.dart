import 'package:go_router/go_router.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/domain/model/image_item.dart';
import 'package:image_search_app/ui/detail/detail.dart';
import 'package:image_search_app/ui/main/main_screen.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => MainViewModel(repository: ImageItemRepositoryImpl()),
        child: const MainScreen(),
      ),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final imageItem = state.extra as ImageItem;
        return DetailScreen(imageItem: imageItem);
      }
    )
  ],
);
