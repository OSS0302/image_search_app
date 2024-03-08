import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_item_repository_impl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱 '),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
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
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(future: ImageItemRepositoryImpl().getImageData(searchController.text),
                  builder: (context, snapshot){
                    if(!snapshot.hasData ){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    final itemItems = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: itemItems.length,
                        itemBuilder: (context, index) {
                          final imageItem = itemItems[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(imageItem.imageUrl,fit: BoxFit.cover,),
                          );

                        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 22,mainAxisSpacing: 22),

                      ),
                    );
                  }),
            )
            
          ],
        ),
      ),
    );
  }
}
