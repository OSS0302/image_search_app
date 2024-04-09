import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final imageSearchController = TextEditingController();
  final pixbayViewModel = PixabayViewModel();

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
            controller: imageSearchController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.pinkAccent,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.pinkAccent,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: '이미지 검색하세요',
                suffixIcon: IconButton(
                  onPressed: () async {
                    await pixbayViewModel
                        .fetchImage(imageSearchController.text);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.pinkAccent,
                  ),
                )),
          ),
          const SizedBox(
            height: 24,
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: pixbayViewModel.loadingStream,
            builder: (context, snapshot) {
              if(snapshot.data! == true){
                return Center(child: CircularProgressIndicator(),);
              }
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22,
                  ),
                  itemCount: pixbayViewModel.imageItem.length,
                  itemBuilder: (context, index) {
                    final imageItem = pixbayViewModel.imageItem[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageItem.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
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
