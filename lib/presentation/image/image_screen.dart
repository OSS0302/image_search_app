import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

import 'image_event.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final searchController = TextEditingController();
  StreamSubscription<ImageEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      subscription = context
          .read<ImageViewModel>()
          .eventStream
          .listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text('이미지 검색앱'),
                content: Text('이미지 검색앱'),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: TextButton(onPressed: () {
                      context.pop();
                    }, child: Text('확인')),
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
    searchController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.read<ImageViewModel>();
    final state = imageViewModel.state;
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
                controller: searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                    BorderSide(width: 2, color: Colors.purpleAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                    BorderSide(width: 2, color: Colors.purpleAccent),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.purpleAccent,
                    ),
                    onPressed: () async {
                      final result = await imageViewModel.fetchImage(
                          searchController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              if (state.isLoading) Center(child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('잠시만 기다려 주세요'),
                ],
              ),) else Expanded(
                child: GridView.builder(
                  itemCount: state.imageItem.length,
                  itemBuilder: (context, index) {
                    final imageItems = state.imageItem[index];
                    return GestureDetector(
                      onTap: () async{
                        await showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text('이미지 검색앱'),
                            content: Text('이미지 검색앱'),
                            actions: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white
                                ),
                                child: TextButton(onPressed: () {
                                  context.push('/detail', extra: imageItems);
                                  context.pop();
                                }, child: Text('확인')),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white
                                ),
                                child: TextButton(onPressed: () {
                                  context.pop();
                                }, child: Text('취소')),
                              )
                            ],
                          );
                        }).then((value) {
                          if(value != null && value) {}
                        });
                      },
                        child: ImageWidget(imageItems: imageItems));
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
