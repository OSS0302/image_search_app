import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
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
        title: const Text('pixabay 이미지 검색앱'),
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
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.amber,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.amber,
                    ),
                  ),
                  hintText: '이미지를 검색하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search_rounded),
                    onPressed: () async {
                      await pixabayViewModel
                          .searchImage(textEditingController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 24,
              ),
              StreamBuilder(
                initialData: false,
                stream: pixabayViewModel.isLoadingStream,
                builder: (context, snapshot) {
                  if (snapshot.data! == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: pixabayViewModel.pixabyItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems = pixabayViewModel.pixabyItem[index];
                        return PixabayWidget(pixabayItems: pixabayItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
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
