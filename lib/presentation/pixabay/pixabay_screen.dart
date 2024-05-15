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
  final pixabaySearchController = TextEditingController();


  @override
  void dispose() {
    pixabaySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
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
                controller: pixabaySearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.amberAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.amberAccent,
                    ),
                  ),
                  hintText: '이미지를 검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search_rounded),
                    onPressed: () async {
                     final result =  await pixabayViewModel
                          .searchImage(pixabaySearchController.text);
                     if(result == false){
                       const snackBar = SnackBar(content: Text('네트워크 오류'));
                       if(mounted){
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }

                     }
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              state.isLoading ? Center(child: CircularProgressIndicator(),)
               : Expanded(
                    child: GridView.builder(
                      itemCount: state.pixabayItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems =
                        state.pixabayItem[index];
                        return PixabayWidget(pixabayItems: pixabayItems);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
