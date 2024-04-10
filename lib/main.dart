<<<<<<< riverpod
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/routes.dart';
=======
>>>>>>> main




import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/presentation/main/pixabay_screen.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
import 'package:image_search_app/routes.dart';
import 'package:provider/provider.dart';

void main() {
<<<<<<< riverpod
  diSetUp();
  runApp(ProviderScope(child: MyApp()));
=======
  diSetup();
  runApp(const MyApp());
>>>>>>> main
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

    );
  }
}
