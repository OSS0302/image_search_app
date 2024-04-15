import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    subscription = context.read<MainViewModel>().eventStream.listen((event) {
      switch (event) {
        case ShowSnackBar():
          final snackBar = SnackBar(content: Text(event.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        case ShowDialog():
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('이미지 검색 앱'),
                  content: const Text('이미지를 가져 왔습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('확인'),
                    ),
                  ],
                );
              });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    final state = mainViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 앱 '),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.deepOrangeAccent,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  hintText: '이미지 앱',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      await mainViewModel
                          .fetchImage(textEditingController.text);
                      setState(() {});
                    },
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
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('이미지 검색 앱'),
                                        content: Text('자세히 보시겠습니까'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context.pop(true);
                                              context.push('/detail',
                                                  extra: imageItem);
                                            },
                                            child: Text('확인'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: Text('취소'),
                                          ),
                                        ],
                                      );
                                    }).then((value) {
                                    if (value != null && value) {}
                                });
                              },
                              child: ImageWidget(imageItem: imageItem));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
