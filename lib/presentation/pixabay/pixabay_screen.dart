import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';
import 'package:provider/provider.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final imageSearchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.watch<PixabayViewModel>();
    final state = pixabayViewModel.state;
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
                controller: imageSearchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  hintText: '이미지를 검색하세요',
                  suffixIcon: IconButton(
                    onPressed: () async {
                       await pixabayViewModel
                          .fetchImage(imageSearchController.text);


                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              state.isLoading ? const Center(child: CircularProgressIndicator(),)
              : Expanded(
                child: GridView.builder(
                  itemCount: state.pixabayItem.length,
                  itemBuilder: (context, index) {
                    final pixabayItems = state.pixabayItem[index];
                    return PixabayWidget(pixabayItems: pixabayItems);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
