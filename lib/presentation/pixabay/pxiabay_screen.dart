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
  final imageSearchController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
   Future.microtask(() {
     subscription = context.read<PixabayViewModel>().eventStream.listen((event) {
       switch(event){
         case ShowSnackBar():
           final snackBar = SnackBar(content: Text(event.message));
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
         case ShowDialog():
           showDialog(context: context, builder: (context){
             return AlertDialog(
               title: Text('이미지 검색앱'),
               content: Text('이미지 데이터 가져왔습니다.'),
               actions: [
                 Container(
                   decoration: BoxDecoration(
                     color: Colors.blueAccent,
                     borderRadius: BorderRadius.circular(20),
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
    imageSearchController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
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
              controller: imageSearchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green,
                  ),
                ),
                hintText: '이미지 앱',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () async {
                   final result =  await pixabayViewModel
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
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('로딩중입니다 잠시만 기다려주세요')
                      ],
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: state.pixabayItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems = state.pixabayItem[index];
                        return GestureDetector(
                          onTap: () async{
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: Text('이미지 검색앱'),
                                content: Text('자세히 보시겠습니까?'),
                                actions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(onPressed: () {
                                      context.pop();
                                      context.push('/detail', extra: pixabayItems);

                                    }, child: Text('확인')),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(onPressed: () {
                                      context.pop();

                                    }, child: Text('취소')),
                                  )
                                ],
                              );
                            }).then((value) {
                              if(value != null && value){}
                            });
                          },
                            child: PixabayWidget(pixabayItems: pixabayItems));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 32),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
