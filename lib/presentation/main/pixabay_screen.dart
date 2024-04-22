import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textEditingController = TextEditingController();
  final pixabayViewModel = PixabayViewModel();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        await pixabayViewModel
                            .fetchImage(textEditingController.text);
                        setState(() {});
                      },
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              StreamBuilder<bool>(
                initialData: false,
                stream: pixabayViewModel.isLoadingStream,
                builder: (context, snapshot) {
                  if(snapshot.data! == true) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: pixabayViewModel.pixabayItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems = pixabayViewModel.pixabayItem[index];
                        return PixabayWdiget(pixabayItems: pixabayItems);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32,
                      ),
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
