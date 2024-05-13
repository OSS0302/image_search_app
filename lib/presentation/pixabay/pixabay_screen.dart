import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
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
        title: const Text('이미지 검색 앱'),
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
                      color: Colors.lightGreenAccent,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.lightGreenAccent,
                      width: 2,
                    ),
                  ),
                  hintText: '이미지 를 검색하세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.lightGreenAccent,
                    ),
                    onPressed: () async{
                      await pixabayViewModel.fetchImage(textEditingController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
               StreamBuilder<bool>(
                 initialData: false,
                   stream: pixabayViewModel.isLoadingStream, builder: (context ,snapshot){
                 if(snapshot.data! == true){
                   return Center(child: Column(
                     children: [
                       CircularProgressIndicator(),
                       Text('잠시만 기다려 주세요')
                     ],
                   ));
                 }
                 return Expanded(
                   child: GridView.builder(
                     itemCount: pixabayViewModel.pixabayItem.length,
                     itemBuilder: (context, index) {
                       final pixabayItems =
                       pixabayViewModel.pixabayItem[index];
                       return PixabayWidget(pixabayItems: pixabayItems);
                     },
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 4,
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
