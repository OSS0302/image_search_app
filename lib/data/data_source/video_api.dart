import '../../key.dart';
import '../dto/video_dto.dart';
import 'package:http/http.dart'as http;
class VideoApi {
  Future<VideoDto> getVideoResult(String query) async{
    final response = await http.get(Uri.parse('https://pixabay.com/api/videos/?key=38081108-118a6127b8642576a388e6c5e&q=yellow+flowers&pretty=true'));
    return VideoDto.fromJson(response.body);
  }
}