import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/image_widget.dart';
import 'main_event.dart';
import 'main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchTextController = TextEditingController();
  StreamSubscription<MainEvent>? subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MainViewModel>().eventStream.listen((event) {
        switch(event) {
          case ShowSnackBar():
            final snackBar = SnackBar(
              content: Text(event.message),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
          // showDialog(context: context, builder: (context) {
          // });
        }
      });
    });
  }
  @override
  void dispose() {
    subscription?.cancel();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    final state = mainViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱 '),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.orange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.orange
                    ),
                  ),
                  hintText: '이미지 검색 하세요',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
                    onPressed: () async {
                      await mainViewModel.searchImage(
                          searchTextController.text);
                    }
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
          state.isLoading
          ? const Center(child: CircularProgressIndicator(),)
          :  Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 22,
                crossAxisSpacing: 22,
              ),
              itemCount: state.imageItems.length,
              itemBuilder: (BuildContext context, int index) {
                final imageItem = state.imageItems[index];
                return ImageWidget(imageItem: imageItem);
              },
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
