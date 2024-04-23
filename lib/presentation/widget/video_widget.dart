import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/video_item.dart';

class VideoWidget extends StatelessWidget {
  final VideoItem videoItem;
  const VideoWidget({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(videoItem.pageURL,fit: BoxFit.cover),
    );
  }
}
