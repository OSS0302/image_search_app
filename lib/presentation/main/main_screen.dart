import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
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
    final state = mainViewModel.state;
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
                controller: searchController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.greenAccent,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search_outlined),
                      onPressed: () async {
                        await mainViewModel.searchImage(searchController.text);
                        setState(() {});
                      },
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: state.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = state.imageItem[index];
                          return ImageWidget(imageItems: imageItems);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
