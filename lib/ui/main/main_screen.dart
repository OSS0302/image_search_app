import 'package:flutter/material.dart';
import 'package:image_search_app/ui/image_widget/image_widget.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchImageController = TextEditingController();

  @override
  void dispose() {
    searchImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지검색앱 '),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchImageController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  hintText: '이미지검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        mainViewModel.fatchImage(searchImageController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            mainViewModel.isLoading  ? Center(child: CircularProgressIndicator(),)
        : Expanded(
                  child: GridView.builder(
                    itemCount: mainViewModel.imageItems.length,
                    itemBuilder: (context, index) {
                      final imageItem = mainViewModel.imageItems[index];
                      return ImageWidget(imageModel: imageItem);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                    ),
                  ),

              
            ),
          ],
        ),
      ),
    );
  }
}
