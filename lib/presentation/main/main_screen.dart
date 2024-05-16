import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

import '../../data/model/image_item.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();
  final mainViewModel = MainViewModel();

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('이미지 검색앱'),
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
                    color: Colors.indigo,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.indigo,
                  ),
                ),
                hintText: '이미지 검색앱',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () async{
                    await mainViewModel.fetchImage(imageSearchController.text);
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder<List<ImageItem>>(
                future: ImageRepositoryImpl()
                    .getImageItems(imageSearchController.text),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려주세요'),
                        ],
                      ),
                    );
                  }
                  final imageItem = snapshot.data!;
                  return Expanded(
                      child: GridView.builder(
                    itemCount: mainViewModel.imageItem.length,
                    itemBuilder: (context, index) {
                      final imageItems = mainViewModel.imageItem[index];
                      return ImageWidget(imageItems: imageItems);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32),
                  ));
                }),
          ],
        ),
      )),
    );

  }
}
