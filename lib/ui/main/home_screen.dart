import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/ui/main/home_view_model.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final textEditingController = TextEditingController();
  final homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ImageSearch app',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async{
                     await homeViewModel.fetchImage(textEditingController.text);
                     setState(() {

                     });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              homeViewModel.isLoading ? Center(child:  CircularProgressIndicator(),)
            :  Expanded(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 22,
                            crossAxisSpacing: 22,
                          ),
                          itemCount: homeViewModel.imageItems.length,
                          itemBuilder: (context, index){
                            final imageItem = homeViewModel.imageItems[index];
                            return ImageWidget(imageItem: imageItem);
                          }),
                    )


            ],
          ),
        ),
      ),
    );
  }
}
