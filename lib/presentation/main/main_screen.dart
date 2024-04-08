import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainViewModel = context.watch<MainViewModel>();
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    hintText: '이미지 검색앱',
                    suffixIcon: IconButton(
                      onPressed: () {
                        mainViewModel.fetchImage(textEditingController.text);
                        setState(() {});
                      },
                      icon: const Icon(Icons.search),
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              StreamBuilder<bool>(
                initialData: false,
                stream: mainViewModel.loadingStream,
                builder: (context , snapshot){
                  if(snapshot.data! == true){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: mainViewModel.imageItems.length,
                      itemBuilder: (context, index) {
                        final imageItems = mainViewModel.imageItems[index];
                        return ImageWidget(imageItem: imageItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 22,
                        crossAxisSpacing: 22,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
