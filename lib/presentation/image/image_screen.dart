import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/domain/model/image_item.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/image_wdiget.dart';
import 'package:provider/provider.dart';

import 'image_event.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final textEditingController = TextEditingController();
   StreamSubscription<ImageEvent>?  subscription;

  @override
  void initState() {
    Future.microtask(() {
     subscription = context.read<ImageViewModel>().eventStream.listen((event) {
       switch(event){

         case ShowSnackBar():
          final snackBar = SnackBar(content: Text(event.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
         case ShowDialog():
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: Text('이미지 검색앱'),
                content: Text('데이터 가져오기'),
                actions: [
                  TextButton(onPressed: () {
                    context.pop();
                  }, child: Text('확인'))
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
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.watch<ImageViewModel>();
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
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  hintText: '이미지 검색 앱',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () async {
                       await imageViewModel
                          .searchImage(textEditingController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              state.isLoading ? const Center(child: CircularProgressIndicator(),)
             : Expanded(
                child: GridView.builder(
                  itemCount: state.imageItem.length,
                  itemBuilder: (context, index) {
                    final imageItems = state.imageItem[index];
                    return GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext  context){
                              return AlertDialog(
                                title: Text('이미지 검색앱'),
                                content : Text('자세히 보시겠습니까?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop(true);
                                      context.push('/detail',extra: imageItems);
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
                            if(value != null && value){}
                          });
                        },
                        child: ImageWidget(imageItem: imageItems,));
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
