import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/ui/main/main_view_model.dart';
import 'package:image_search_app/ui/widget/image_item_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
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
                controller: searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  hintText: '이미지검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      mainViewModel.fetchImage(searchController.text);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              mainViewModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: mainViewModel.imageItems.length,
                        itemBuilder: (context, index) {
                          final imageItem = mainViewModel.imageItems[index];
                          return GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Image.network(
                                    imageItem.imageUrl,
                                    width: 500,
                                    height: 500,
                                    fit: BoxFit.cover,
                                  ),
                                  Checkbox(
                                      value: mainViewModel.favorites
                                          .contains(imageItem.id),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value! == true) {
                                            mainViewModel.favorites
                                                .add(imageItem.id);
                                          } else {
                                            mainViewModel.favorites.remove(imageItem.id);
                                          }
                                        });
                                      })
                                ],
                              ),
                            ),
                            onTap: () {
                              context.push('/detail', extra: imageItem);
                            },
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 22,
                            mainAxisSpacing: 22),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
