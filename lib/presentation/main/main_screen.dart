import 'package:flutter/material.dart';
import 'package:image_search_app/data/reposiotory/image_repository.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

import '../../data/model/image_item.dart';

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
                    borderSide: BorderSide(
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
                    onPressed: ()  {
                      setState(() {

                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder(
                  future: ImageRepositoryImpl()
                      .getImageResult(imageSearchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final imageItems = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 22,
                              crossAxisSpacing: 22),
                          itemCount: imageItems.length,
                          itemBuilder: (context, index) {
                            final imageItem = imageItems[index];
                            return ImageWidget(imageItem: imageItem);
                          }),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
