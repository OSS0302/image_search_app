import 'dart:convert';

import '../../key.dart';
import '../dto/image_dto.dart';
import 'package:http/http.dart' as http;
class PixabayApi {
  Future<ImageDto> getImageResult(String query) async{
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=$key&q=$query&pretty=true'));
    return ImageDto.fromJson(jsonDecode(response.body));
  }
}