import 'package:flutter/material.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱 '),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
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
                  hintText: '이미지 검색 하세요',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      mainViewModel.searchImage(searchController.text);
                    },
                  ),
                ),
              ),
            ),
            mainViewModel.isLoading ? const Center(child: CircularProgressIndicator(),)
              :  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: mainViewModel.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItem = mainViewModel.imageItem[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imageItem.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 22,
                            mainAxisSpacing: 22),
                      ),
                    ),
                  )


          ],
        ),
      ),
    );
  }
}
