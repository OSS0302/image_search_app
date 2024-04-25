import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final textEditingController = TextEditingController();
  final mainViewModel = MainViewModel();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                  hintText: '이미지 검색 해주세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.purple,
                    ),
                    onPressed: () async {
                      await mainViewModel
                          .fetchImage(textEditingController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              StreamBuilder<bool>(
                initialData: false,
                stream: mainViewModel.eventStream,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: mainViewModel.pixabayItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems = mainViewModel.pixabayItem[index];
                        return ImageWidget(pixabayItems: pixabayItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32),
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
