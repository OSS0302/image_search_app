import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';

import '../../data/model/image_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱 '),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.orange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.orange
                    ),
                  ),
                  hintText: '이미지 검색 하세요',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<List<ImageItem>>(
                  future: ImageItemRepositoryImpl()
                      .getSearchImage(searchTextController.text),
                  builder: (context, snanshot) {
                    if (!snanshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final imageItems = snanshot.data!;
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 22,
                          crossAxisSpacing: 22,
                        ),
                        itemCount: imageItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final imageItem = imageItems[index];
                          return ImageWidget(imageItem: imageItem);
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
