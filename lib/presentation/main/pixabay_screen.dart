import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final imageSearchController = TextEditingController();

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
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.pinkAccent,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.pinkAccent,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: '이미지 검색하세요',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.pinkAccent,
                      ),
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<List<PixabayItem>>(
                future: PixabayRepositoryImpl()
                    .getResult(imageSearchController.text),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final imageItems = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 22,
                        crossAxisSpacing: 22,
                      ),
                      itemCount: imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItem = imageItems[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(imageItem.imageUrl,fit: BoxFit.cover,),
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
