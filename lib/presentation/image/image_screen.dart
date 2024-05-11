import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();
  final imageViewModel = ImageViewModel();

  @override
  Widget build(BuildContext context) {
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
              controller: imageSearchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.yellowAccent,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.yellowAccent,
                    width: 2,
                  ),
                ),
                hintText: '이미지를 검색하세요',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.yellowAccent,
                  ),
                  onPressed: () async {
                    await imageViewModel.fetchImage(imageSearchController.text);
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: imageViewModel.isLoadingStream,
              builder: (context, snapshot) {
                if (snapshot.data! == true) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('로딩중입니다. 잠시만 기달려주새요'),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32,
                    ),
                    itemCount: imageViewModel.imageItem.length,
                    itemBuilder: (context, index) {
                      final imageItems = imageViewModel.imageItem[index];
                      return ImageWidget(imageItems: imageItems);
                    },
                  ),
                );
              },

            ),

          ],
        ),
      )),
    );
  }
}
