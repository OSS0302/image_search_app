import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/main/pixabay_event.dart';
import 'package:image_search_app/presentation/main/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';


class PixabayScreen extends ConsumerStatefulWidget {
  const PixabayScreen({super.key});

  @override
  ConsumerState createState() => _PixabayScreenState();
}


class _PixabayScreenState extends ConsumerState<PixabayScreen> {
  StreamSubscription<PixabayEvent>? subscription;
  final searchImageController = TextEditingController();

    @override
  void initState() {
    super.initState();
    Future.microtask(() {
      subscription = ref.read(pixabayViewModelProvider.notifier).eventStream.listen((event) {
        switch(event){
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
        }
      });
    });
  }
  @override
  void dispose() {
    subscription?.cancel();
    searchImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pixabayViewModelProvider);
    final notifier = ref.read(pixabayViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 앱'),
      ),

      body: state.when(
          data: (data) {
            return SafeArea(
              child: state.value!.isLoading
                  ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                        Text('찾는중.....')
                      ],
                                  ),
                  )
                  : Padding(
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
                          onPressed: () {
                            // await pixabayViewModel.fetchImage(searchImageController.text);
                            notifier.fetchImage(searchImageController.text);
                          },
                        ),
                      ),
                      onSubmitted: (value){
                        notifier.fetchImage(searchImageController.text);
                      },
                    ),
                    const SizedBox(height: 24),
                    state.isLoading ? const Center(child: CircularProgressIndicator(),)
                    : Expanded(
                      child: GridView.builder(
                        itemCount: state.value?.imageItems.length,
                        itemBuilder: (context, index) {
                          final imageItem = state.value?.imageItems[index];
                          return GestureDetector(
                            onTap: (){
                              context.push('/detail',extra: imageItem);
                            },
                              child: ImageWidget(imageItems: imageItem!,));
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
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text('error'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
            TextField(
            controller: imageSearchController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.pinkAccent,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.pinkAccent,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: '이미지 검색하세요',
                suffixIcon: IconButton(
                  onPressed: () async {
                  final result =  await pixbayViewModel
                        .fetchImage(imageSearchController.text);
                  if(result == false){
                   const snackBar =SnackBar(content: Text('오류'));
                   if(mounted){
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   }
                  }

                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.pinkAccent,
                  ),
                )),
          ),
          const SizedBox(
            height: 24,
          ),
          state.isLoading ? Center(child: CircularProgressIndicator(),)
              : Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22,
                  ),
                  itemCount: state.imageItem.length,
                  itemBuilder: (context, index) {
                    final imageItem = state.imageItem[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageItem.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),


          ),

            ],
          ),
        ),
>>>>>>> main
      ),
    );
  }
}

