import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final imageSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder<List<PixabayItem>>(
              future: PixabayRepositoryImpl()
                  .getPixabayItems(imageSearchController.text),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final pixabayItem = snapshot.data!;
                return Expanded(
                    child: GridView.builder(
                  itemCount: pixabayItem.length,
                  itemBuilder: (context, index){
                    final pixabayItems = pixabayItem[index];
                    return PixabayWidget(pixabayItems: pixabayItems);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 32,mainAxisSpacing: 32),
                ));
              },
            ),
          ],
        ),
      )),
    );
  }
}
