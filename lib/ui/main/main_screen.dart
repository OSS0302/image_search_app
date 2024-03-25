import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';
import 'package:provider/provider.dart';
import '../../data/model/image_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyan,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyan,
                    ),
                  ),
                  hintText: '이미지 검색하세요',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await mainViewModel.fetchImage(textController.text);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              StreamBuilder(stream: mainViewModel.isLoadingStream,
                builder: (context,snapshot){
                if(snapshot == true) {
                  return const CircularProgressIndicator();
                }
               return Expanded(
                  child: GridView.builder(
                    itemCount: mainViewModel.imageItem.length,
                    itemBuilder: (context, index) {
                      final imageItem = mainViewModel.imageItem[index];
                      return ImageWidget(imageItem: imageItem);
                    },
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                    ),
                  ),
                );
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
