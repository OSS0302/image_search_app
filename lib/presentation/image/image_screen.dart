import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

import '../../data/model/image_item.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();

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
                       final result =  await imageViewModel
                            .fetchImage(imageSearchController.text);
                       if(result == false) {
                         const snackBar = SnackBar(content: Text('네트워크 오류'));
                         if(mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         }

                       }
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
