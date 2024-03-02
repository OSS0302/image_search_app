import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/ui/main/main_screen.dart';
import 'package:image_search_app/presentation/ui/main/main_view_model.dart';
import 'package:image_search_app/routes.dart';
import 'package:provider/provider.dart';


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
      home: ChangeNotifierProvider(
        create: (_) => MainViewModel(),
        child: MainScreen(),
      )
    );
  }
}

