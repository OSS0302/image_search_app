import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';
import 'package:image_search_app/ui/widget/image_item_widget.dart';
import '../../domain/model/image_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();
  final repository = ImageItemRepositoryImpl();
  List<ImageItem> imageItems = [];
  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    setState(() {
      isLoading = true;
    });

    imageItems = await repository.getImageResult(query);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  hintText: '이미지검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      fetchImage(searchController.text);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: imageItems.length,
                  itemBuilder: (context, index){
                    final imageItem = imageItems[index];
                    return ImageItemWidget(imageItem: imageItem);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
