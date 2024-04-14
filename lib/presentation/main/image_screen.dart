import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_item_widget.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => MainScreenState();
}

class MainScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.watch<ImageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.limeAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.limeAccent,
                    ),
                  ),
                  hintText: '이미지 앱',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.limeAccent,
                    ),
                    onPressed: () async {
                      imageViewModel.fetchImage(imageSearchController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              imageViewModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32),
                        itemCount: imageViewModel.imageItems.length,
                        itemBuilder: (context, index) {
                          final imageItem = imageViewModel.imageItems[index];
                          return ImageItemWidget(imageItem: imageItem);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
