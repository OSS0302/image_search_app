import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final searchImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.watch<PixabayViewModel>();
    final state = pixabayViewModel.state;
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blueGrey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blueGrey,
                    ),
                  ),
                  hintText: '이미지 검색하세요',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () async {
                     await pixabayViewModel.fetchImage(searchImageController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              state.isLoading  ? const Center(child: CircularProgressIndicator(),)
              : Expanded(
                child: GridView.builder(
                  itemCount: state.imageItems.length,
                  itemBuilder: (context, index) {
                    final imageItem = state.imageItems[index];
                    return ImageWidget(imageItems: imageItem);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
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
