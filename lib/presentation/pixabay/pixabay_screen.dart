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
    Future.microtask(() {
      subscription = context.read<PixabayViewModel>().eventStream.listen((event) {
        switch(event) {

          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text('imageSearchApp'),
                content: Text('Image Data Complete'),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightGreenAccent
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
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 앱'),
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
                      color: Colors.lightGreenAccent,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.lightGreenAccent,
                      width: 2,
                    ),
                  ),
                  hintText: '이미지 를 검색하세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.lightGreenAccent,
                    ),
                    onPressed: () async{
                      await pixabayViewModel.fetchImage(textEditingController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
                state.isLoading ? Center(child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('잠시만 기다려 주세요')
                  ],
                ),)
                :Expanded(
                   child: GridView.builder(
                     itemCount: state.pixabayItem.length,
                     itemBuilder: (context, index) {
                       final pixabayItems =
                       state.pixabayItem[index];
                       return PixabayWidget(pixabayItems: pixabayItems);
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
