import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/domain/repository/image_item_repository.dart';

import '../widget/image_item_widget.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchController,
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
              FutureBuilder(
                future: ImageItemRepositoryImpl().getImageResult(imageSearchController.text),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  final imageItem = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      itemCount: imageItem.length,
                      itemBuilder: (context, index) {
                        final imageItems = imageItem[index];
                        return ImageItemWidget(imageItem: imageItems);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 22,
                        mainAxisSpacing: 22,
                      ),
                    ),
                  );
                },),
            ],
          ),
        ),
      ),
    );
  }
}
