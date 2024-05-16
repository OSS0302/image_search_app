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
    final mainViewModel = context.read<MainViewModel>();
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
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.indigo,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.indigo,
                  ),
                ),
                hintText: '이미지 검색앱',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () async {
                    await mainViewModel.fetchImage(imageSearchController.text);
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            mainViewModel.isLoading
                ? Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('잠시만 기다려주세요'),
                      ],
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: mainViewModel.imageItem.length,
                      itemBuilder: (context, index) {
                        final imageItems = mainViewModel.imageItem[index];
                        return ImageWidget(imageItems: imageItems);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 32,
                              crossAxisSpacing: 32),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
