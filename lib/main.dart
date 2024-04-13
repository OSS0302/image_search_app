import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/image_screen.dart';
import 'package:image_search_app/presentation/main/image_view_model.dart';





void main() {
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
      home: ImageScreen(),
    );
  }
}
