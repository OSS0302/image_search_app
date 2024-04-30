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
  final imageSearchController = TextEditingController();
  final imageViewModel = ImageViewModel();

  @override
  void dispose() {
    imageSearchController.dispose();
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  hintText: '이미지 검색후 (검색창) 버튼을 눌러 주세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.ads_click),
                    color: Colors.black,
                    onPressed: () async {
                      await imageViewModel
                          .fetchImage(imageSearchController.text);
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
                  if(snapshot.data! == true) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: imageViewModel.imageItem.length,
                      itemBuilder: (context, index) {
                        final imageItems = imageViewModel.imageItem[index];
                        return ImageWidget(imageItem: imageItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 32),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
