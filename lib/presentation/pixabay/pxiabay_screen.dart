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
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 앱 '),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: imageSearchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green,
                  ),
                ),
                hintText: '이미지 앱',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () async {
                    await pixabayViewModel
                        .fetchImage(imageSearchController.text);
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            state.isLoading
                ? Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('로딩중입니다 잠시만 기다려주세요')
                      ],
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: state.pixabayItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems = state.pixabayItem[index];
                        return PixabayWidget(pixabayItems: pixabayItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 32),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
