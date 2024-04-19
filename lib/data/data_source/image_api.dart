import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../key.dart';
class ImageApi {
  Future<Map<String , dynamic>> getImageSearch(String query) async {
    final response =  await http.get(Uri.parse('https://pixabay.com/api/?key=$key&q=$query&image_type=photo'));
    return jsonDecode(response.body);
  }
}