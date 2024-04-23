import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/video_item.dart';
import 'package:image_search_app/data/repository/video_repository_impl.dart';
import 'package:image_search_app/presentation/widget/video_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱'),
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
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<List<VideoItem>>(
                  future: VideoRepositoryImpl()
                      .getVideoItem(textEditingController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final videoItems = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                        itemCount: videoItems.length,
                        itemBuilder: (context, index) {
                          final videoItem = videoItems[index];
                          return VideoWidget(videoItem: videoItem);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
