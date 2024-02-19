import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/ui/main_view_model.dart';
import 'package:provider/provider.dart';

import '../domain/model/image_item.dart';

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
    final viewModel = context.watch<MainViewModel>();
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
                      color: Color(0xFF4FB6B2), // 외곽선 컬러 설정
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // 둥글게 만들기 위해 BorderRadius 설정
                    borderSide: const BorderSide(
                      width: 2,
                      color: Color(0xFF4FB6B2), // 외곽선 컬러 설정
                    ),
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF4FB6B2), // 외곽선 컬러 설정
                    ),
                    onPressed: () {
                      // 강제로 화면 다시 그리기
                      viewModel.fetchImage(searchTextEditingController.text);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
                viewModel.isLoading ? Center(child: CircularProgressIndicator())
              : Expanded(
                    child: GridView.builder(
                      itemCount: viewModel.imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = viewModel.imageItems[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20.0), // 코너의 둥근 정도 조절
                          child: Image.network(
                            imageItem.imageUrl,
                            // 이미지 경로
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
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