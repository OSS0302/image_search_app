import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/di_setup/di_setup.dart';
import 'package:image_search_app/presentation/main/image_screen.dart';
import 'package:image_search_app/presentation/main/image_view_model.dart';
import 'package:provider/provider.dart';





void main() {
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => getIt<ImageViewModel>(),
        child: ImageScreen(),
      )
    );
  }
}
