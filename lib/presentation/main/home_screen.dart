import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image_widget/image_widget.dart';
import 'package:image_search_app/presentation/main/home_event.dart';
import 'package:image_search_app/presentation/main/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageSearchController = TextEditingController();
  StreamSubscription<HomeEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      context.read<HomeViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Image_Search_App'),
                  content: Text('이미지를 가져왔습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('확인'),
                    ),
                  ],
                );
              },
            );
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
    final homeViewModel = context.watch<HomeViewModel>();
    final state = homeViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image_Search_App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                    onPressed: () async {
                      final result = await homeViewModel
                          .fetchImage(imageSearchController.text);
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
                        itemCount: state.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = state.imageItem[index];
                          return GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text('Image_Search_App'),
                                    content: Text('자세히 보시겠습니까 ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          context.pop(true);
                                          context.push('/detail', extra: imageItems);
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
                                },
                              ).then((value) {
                                if(value != null &&  value){}
                              });

                            },
                              child:ImageWidget(imageItems: imageItems),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 22,
                          mainAxisSpacing: 22,
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
//
