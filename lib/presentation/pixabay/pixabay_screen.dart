import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';
import 'package:provider/provider.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textEditingController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      subscription =
          context.read<PixabayViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('이미지 검색앱'),
                    content: const Text('이미지 가져오기 완료'),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('확인'),
                        ),
                      ),
                    ],
                  );
                });
        }
      });
    });

  }

  @override
  void dispose() {
    textEditingController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
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
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: '이미지 검색 한후 버튼 눌러주세요',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      await pixabayViewModel
                          .fetchImage(textEditingController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              if (state.isLoading) const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기달려주세요 로딩중입니다.')
                        ],
                      ),
                    ) else Expanded(
                      child: GridView.builder(
                        itemCount: state.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItem = state.pixabayItem[index];
                          return GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('이미지 검색앱'),
                                      content: const Text('이미지 가져오기 완료'),
                                      actions: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.blue,
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              context.push('/detail', extra: pixabayItem);
                                              context.pop();
                                            },
                                            child: const Text('확인'),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.blue,
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: const Text('취소'),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) {
                                  if(value != null && value){}
                                });
                              },
                              child: PixabayWidget(pixabayItem: pixabayItem));
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
