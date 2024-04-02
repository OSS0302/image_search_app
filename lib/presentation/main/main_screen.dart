import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_event.dart';
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
  void initState() {
    Future.microtask(() {
      context.read<MainViewModel>().eventStream.listen((event) {
        switch(event){
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():

        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    final state = mainViewModel.state;
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
                controller: imageSearchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 2, color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 2, color: Colors.brown),
                  ),
                  hintText: '검색하세요',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await mainViewModel
                          .searchImage(imageSearchController.text);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 22,
                  ),
                  itemCount: state.imageItems.length,
                  itemBuilder: (context, index) {
                    final imageItem = state.imageItems[index];
                    return ImageWidget(imageItem: imageItem);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
