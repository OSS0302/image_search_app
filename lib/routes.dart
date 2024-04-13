// import 'package:go_router/go_router.dart';
// import 'package:image_search_app/domain/model/pixabay_item.dart';
// import 'package:image_search_app/presentation/main/detail/detail_screen.dart';
// import 'package:image_search_app/presentation/main/pixabay_screen.dart';
// import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
// import 'package:provider/provider.dart';
// import 'di/di_setup.dart';
//
// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => ChangeNotifierProvider(
//         create: (_) => getIt<PixabayViewModel>(),
//         child: PixabayScreen(),
//       ),
//     ),
//     GoRoute(path: '/detail',builder: (context, state){
//       final imageItem = state.extra as PixabayItem;
//       return DetailScreen(imageItem: imageItem);
//     })
//   ],
// );


import 'package:go_router/go_router.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/presentation/main/pixabay_screen.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => PixabayScreen(),
      // builder: (context, state) => ChangeNotifierProvider(
      //   create: (_) => getIt<PixabayViewModel>(),
      //   child: PixabayScreen(),
      // ),
    ),
  ],
);
