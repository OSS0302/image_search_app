import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/routes.dart';

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
        title: const Text('이미지 앱 '),
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
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: '이미지 검색 해주세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async{
                      await imageViewModel.fetchImage(imageSearchController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              imageViewModel.isLoading ? Center(child: CircularProgressIndicator(),)
              : Expanded(
                    child: GridView.builder(
                      itemCount: imageViewModel.imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = imageViewModel.imageItems[index];
                        return ImageWidget(imageItem: imageItem);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 32),
                    ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}
