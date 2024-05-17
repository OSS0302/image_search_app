import 'dart:convert';

import 'package:go_router/go_router.dart';

import '../../key.dart';
import '../dto/pixabay_dto.dart';
import 'package:http/http.dart'as http;

class PixabayApi {
  Future<PixabayDto> getImageResult(String query) async{
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=$key&q=$query&image_type=photo&pretty=true'));
    return PixabayDto.fromJson(jsonDecode(response.body));

  }
}