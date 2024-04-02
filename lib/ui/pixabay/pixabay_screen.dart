import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/ui/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final pixabayViewModel = PixabayViewModel();
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아미지 앱'),
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
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  hintText: '이미지 앱',
                  suffixIcon: IconButton(
                    onPressed: () {
                      pixabayViewModel.fetchImage(textEditingController.text);
                      setState(() {

                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              StreamBuilder<bool>(
                initialData: false,
                stream: pixabayViewModel.loadingStream,
                builder: (context, snapshot){
                  if(snapshot.data! == true){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: pixabayViewModel.imageItems.length,
                      itemBuilder: (context , index){
                        final imageItem = pixabayViewModel.imageItems[index];
                        return PixabayWidget(imageItem: imageItem);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 22,mainAxisSpacing: 22,),),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
