import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final imageSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF4FB6B2), // 외곽선 컬러 설정
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                // 둥글게 만들기 위해 BorderRadius 설정
                borderSide: const BorderSide(width: 2, color: Colors.cyan),
              ),
              hintText: '',
              suffixIcon: IconButton(
                  icon: const Icon(Icons.search_sharp, color: Colors.cyan),
                  onPressed: () {
                    setState(() {

                    });
                  }),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: FutureBuilder(
              future: ImageRepositoryImpl().getImageSearch(imageSearchController.text),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator(),);
                }
                final imageItems = snapshot.data!;
               return GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 4,
                     mainAxisSpacing: 22,
                     crossAxisSpacing: 22,
                   ),
                   itemCount: imageItems.length,
                   itemBuilder: (context,index){
                  final imageItem = imageItems[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(imageItem.imageUrl,fit: BoxFit.cover,),
                  );
                  
               });
              }
            ),
          )
        ],
      )),
    );
  }
}
