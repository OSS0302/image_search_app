import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/image/image_event.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';


class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();
  StreamSubscription<ImageEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      context.read<ImageViewModel>().eventStream.listen((event) {
        switch(event) {

          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text('이미지 검색앱 '),
                content: Text('이미지 가져오기 완료'),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent,
                    ),
                      child: TextButton(onPressed: () {
                        context.pop();
                      }, child: Text('확인')))
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
    final imageViewModel = context.read<ImageViewModel>();
    final state = imageViewModel.state;
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
                controller: imageSearchController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blueAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blueAccent,
                      ),
                    ),
                    hintText: '이미지 검색앱',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search_rounded),
                      onPressed: () async {
                   await imageViewModel
                            .fetchImage(imageSearchController.text);

                        setState(() {});
                      },
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              state.isLoading ? Center(child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('잠시만 기다려 주세요'),
                ],
              ),)
              : Expanded(
                    child: GridView.builder(
                      itemCount: state.imageItem.length,
                      itemBuilder: (context, index) {
                        final imageItems = state.imageItem[index];
                        return ImageWidget(imageItems: imageItems);
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
