import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();
  final mainViewModel = MainViewModel();

  @override
  Widget build(BuildContext context) {
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
              StreamBuilder<bool>(
                initialData: false,
                stream: mainViewModel.isLoadingStream,
                builder: (context, snapshot){
                  if(snapshot.data! == true) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: mainViewModel.imageItem.length,
                      itemBuilder: (context, index) {
                        final imageItems = mainViewModel.imageItem[index];
                        return ImageWidget(imageItems: imageItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
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
