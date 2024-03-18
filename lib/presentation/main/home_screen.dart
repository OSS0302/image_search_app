import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_search_app/ui/main/home_view_model.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
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
                    icon: const Icon(Icons.search),
                    onPressed: () async{
                     await homeViewModel.fetchImage(textEditingController.text);
                     setState(() {

                     });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              homeViewModel.isLoading ? const Center(child:  CircularProgressIndicator(),)
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
