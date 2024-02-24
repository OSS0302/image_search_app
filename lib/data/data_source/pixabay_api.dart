import 'dart:convert';

import '../dto/image_dto.dart';
import 'package:http/http.dart' as http;
class PixabayApi{
  Future<ImageDto> getImageData(String query) async {
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$query&imagetype=photo'));
    return ImageDto.fromJson(jsonDecode(response.body));
  }
}