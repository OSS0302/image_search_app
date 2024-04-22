import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/main/pixabay_event.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
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
      subscription =
          context.read<PixabayViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: Text('이미지 검색앱'),
                content: Text('데이터를 가져왔습니다.'),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
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
    final pixabayViewModel = context.watch<PixabayViewModel>();
    final state = pixabayViewModel.state;
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        await pixabayViewModel
                            .fetchImage(textEditingController.text);
                        setState(() {});
                      },
                    )),
              ),
              const SizedBox(
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
                          return PixabayWdiget(pixabayItems: pixabayItems);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32,
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
