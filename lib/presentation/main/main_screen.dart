import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchImageController = TextEditingController();
  final mainViewModel = MainViewModel();

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
                controller: searchImageController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                  hintText: '이미지를 검색하세요 ',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      mainViewModel.fetchImage(searchImageController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              FutureBuilder(
                  future: ImageRepositoryImpl().getImageSearch(
                      searchImageController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    final imageItems = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 22,
                          crossAxisSpacing: 22,
                        ),
                        itemCount: mainViewModel.imageItems.length,
                        itemBuilder: (context, index) {
                          final imageItem = mainViewModel.imageItems[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(imageItem.imageUrl,fit: BoxFit.cover,),
                          );
                        },
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
