import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final imageSearchController = TextEditingController();

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyanAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await mainViewModel
                          .searchImage(imageSearchController.text);
                      setState(() {});
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              mainViewModel.isLoading  ? Center(child: CircularProgressIndicator(),)
                  : Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 22,
                            crossAxisSpacing: 22),
                    itemCount: mainViewModel.imageItems.length,
                    itemBuilder: (context, index) {
                      final imageItem = mainViewModel.imageItems[index];
                      return ImageWidget(imageItem: imageItem);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
