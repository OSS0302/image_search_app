import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final textEditingController = TextEditingController();
  final imageViewModel = ImageViewModel();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  hintText: '이미지검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search_rounded),
                    onPressed: () async {
                      await imageViewModel
                          .searchImage(textEditingController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              imageViewModel.isLoaidng
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: imageViewModel.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = imageViewModel.imageItem[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imageItems.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
