import 'dart:convert';

import 'package:http/http.dart'as http;

import '../../key.dart';
import '../dto/image_dto.dart';
class PixabayApi {
  Future<ImageDto> getImageResult(String query) async{
    final response =await http.get(Uri.parse('https://pixabay.com/api/?key=$key&q=$query&image_type=photo'));
    return ImageDto.fromJson(jsonDecode(response.body));
  }
}