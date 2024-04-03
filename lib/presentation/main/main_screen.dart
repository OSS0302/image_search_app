import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
    final state = mainViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱 '),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchImageController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                  hintText: '이미지를 검색하세요 ',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                    final result =  await mainViewModel.fetchImage(searchImageController.text);
                    if(result == false){
                      const snackBar = SnackBar(content: Text('bay'));
                      if(mounted){
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                      setState(() {});
                    },
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
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22,
                  ),
                  itemCount: state.imageItems.length,
                  itemBuilder: (context, index) {
                    final imageItem = state.imageItems[index];
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
      ),
    );
  }
}
