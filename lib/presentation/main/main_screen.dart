import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

import 'main_event.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final textEditingController = TextEditingController();
  StreamSubscription<MainEvent>? subscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      subscription = context.read<MainViewModel>().eventstream.listen((event) {
        switch(event){
          case ShowSnackBar():
            final snackBar =SnackBar(content: Text(event.message));
          case ShowDialog():
        }
      });
    });


  }

  @override
  void dispose() {
    subscription?.cancel();
    textEditingController.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    final state = mainViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    hintText: '이미지 검색앱',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await mainViewModel
                            .fetchImage(textEditingController.text);
                        setState(() {});
                      },
                      icon: const Icon(Icons.search),
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              state.isLoading ? Center(child: CircularProgressIndicator(),)

                  : Expanded(
                child: GridView.builder(
                  itemCount: state.imageItems.length,
                  itemBuilder: (context, index) {
                    final imageItems = state.imageItems[index];
                    return ImageWidget(imageItem: imageItems);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
