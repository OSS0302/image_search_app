import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';
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
    Future.microtask(() {
      subscription = context.read<MainViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('이미지 검색앱'),
                    content: Text('데이터 가져오기 완료'),
                    actions: [
                      Container(
                        child: TextButton(onPressed: () {
                          context.pop();
                        }, child: Text('확인')),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.cyan
                        ),
                      ),
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
    super.dispose();
    textEditingController.dispose();
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                  hintText: '이미지 검색 해주세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.purple,
                    ),
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
                        itemCount: state.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItems = state.pixabayItem[index];
                          return  GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext  context){
                                    return AlertDialog(
                                      title: Text('이미지 검색앱'),
                                      content : Text('자세히 보시겠습니까?'),
                                      actions: [
                                        Container(
                                          child: TextButton(
                                            onPressed: () {
                                              context.pop(true);
                                              context.push('/detail',extra: pixabayItems);
                                            },
                                            child: Text('확인'),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.cyan
                                          ),
                                        ),
                                        Container(

                                          child: TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: Text('취소'),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.cyan
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) {
                                  if(value != null && value){}
                                });
                              },
                              child: ImageWidget(pixabayItems: pixabayItems));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
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
