import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/domain/model/image_model.dart';
import 'package:image_search_app/ui/image_widget/image_widget.dart';
import 'package:image_search_app/ui/main/main_event.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchImageController = TextEditingController();
  StreamSubscription<MainEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      context.read<MainViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    searchImageController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    final state = mainViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지검색앱 '),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchImageController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  hintText: '이미지검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      final result = await mainViewModel
                          .fatchImage(searchImageController.text);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: state.imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = state.imageItems[index];
                        return GestureDetector(
                          onTap: () {
                            context.push('/detail', extra: imageItem);
                          },
                          child: Image.network(imageItem.imageUrl,width: 200, height: 200,fit: BoxFit.cover,),

                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 22,
                        mainAxisSpacing: 22,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
