import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/routes.dart';
import 'package:image_search_app/ui/pixabay/pixabay_screen.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';

import 'di/di_setup.dart';

void main() {
  diSetUp();
  runApp(const MyApp());
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
