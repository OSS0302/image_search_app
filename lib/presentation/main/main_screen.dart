import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../domain/model/image_items.dart';
import '../widget/image_item_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // 둥글게 만들기 위해 BorderRadius 설정
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blue, // 외곽선 컬러 설정
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // 강제로 화면 다시 그리기
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<ImageItems>>(
                future: ImageRepositoryImpl()
                    .getImageItems(searchTextEditingController.text),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final imageItems = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      itemCount: imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = imageItems[index];
                        return ImageItemWidget(imageItems: imageItem);
                      },
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32,
                      ),
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