import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final textEditingController = TextEditingController();


  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.watch<ImageViewModel>();
    final state = imageViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  hintText: '이미지 검색 앱',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () async {
                     final result =  await imageViewModel
                          .searchImage(textEditingController.text);
                     if(result == false) {
                       const snackBar = SnackBar(content: Text('오류'));
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
              state.isLoading ? const Center(child: CircularProgressIndicator(),)
             : Expanded(
                child: GridView.builder(
                  itemCount: state.imageItem.length,
                  itemBuilder: (context, index) {
                    final imageItems = state.imageItem[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageItems.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
