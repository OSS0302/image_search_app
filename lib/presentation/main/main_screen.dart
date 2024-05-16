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
  final imageSearchController = TextEditingController();
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
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('이미지 검색앱'),
                    content: Text('이미지 데이터 가져오기 완료'),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.indigo,
                        ),
                        child: TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                              '확인',
                              style: TextStyle(color: Colors.black),
                            )),
                      )
                    ],
                  );
                });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.read<MainViewModel>();
    final state = mainViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: imageSearchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.indigo,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.indigo,
                  ),
                ),
                hintText: '이미지 검색앱',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () async {
                    final result = await mainViewModel
                        .fetchImage(imageSearchController.text);

                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            state.isLoading
                ? Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('잠시만 기다려주세요'),
                      ],
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: state.imageItem.length,
                      itemBuilder: (context, index) {
                        final imageItems = state.imageItem[index];
                        return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('이미지 검색앱'),
                                      content: Text('이미지 데이터 가져오기 완료'),
                                      actions: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.indigo,
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                context.push('/detail', extra: imageItems);
                                                context.pop();
                                              },
                                              child: Text(
                                                '확인',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.indigo,
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Text(
                                                '취소',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: ImageWidget(imageItems: imageItems));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 32,
                              crossAxisSpacing: 32),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
