import 'package:flutter/material.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final imageSearchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
     final mainViewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱 '),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: imageSearchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // 둥글게 만들기 위해 BorderRadius 설정
                  borderSide: const BorderSide(width: 2, color: Colors.cyan),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // 둥글게 만들기 위해 BorderRadius 설정
                  borderSide: const BorderSide(width: 2, color: Colors.cyan),
                ),
                hintText: '이미지를 검색하세요!',
                suffixIcon: IconButton(
                    icon: const Icon(Icons.search_sharp, color: Colors.cyan),
                    onPressed: () async {
                      await mainViewModel.fetchImage(imageSearchController.text);
                      setState(() {});
                    }),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            mainViewModel.isLoading ? const Center( child: Column(
              children: [
                CircularProgressIndicator(),
                Text('데이터 로딩중입니다.')
              ],
            ),
                  )
                : Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 22,
                        crossAxisSpacing: 22,
                      ),
                      itemCount: mainViewModel.imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = mainViewModel.imageItems[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            imageItem.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
