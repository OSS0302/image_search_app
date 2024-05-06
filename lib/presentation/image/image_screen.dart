import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final textEditingController = TextEditingController();
  final imageViewModel = ImageViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 이미지 앱 '),
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.ads_click_rounded),
                    onPressed: () async {
                      await imageViewModel.fetchImage(textEditingController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              imageViewModel.isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('데이터 로딩중입니다.')
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: imageViewModel.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = imageViewModel.imageItem[index];
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