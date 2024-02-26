import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../domain/model/image_items.dart';
import '../widget/image_item_widget.dart';
import 'main_view_model.dart';

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
    final mainViewModel = context.watch<MainViewModel>();
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
                      setState(() {
                        mainViewModel.fatchImage(searchTextEditingController.text);
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
                   mainViewModel.isLoading ? isLoadingWidget()
                  : Expanded(
                    child: GridView.builder(
                      itemCount: mainViewModel.imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = mainViewModel.imageItems[index];
                        return ImageItemWidget(imageItems: imageItem);
                      },
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32,
                      ),
                    ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget isLoadingWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(child: CircularProgressIndicator(),),
      Text('로딩중입니다 '),
    ],
  );
  
}