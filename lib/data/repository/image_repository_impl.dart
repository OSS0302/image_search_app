import 'dart:convert';

import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/dto/image_dto.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/data/model/image_item.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final _api = ImageApi();
  @override
  Future<List<ImageItem>> getImageItem(String query) async{
    final json = await _api.getImageSearch(query);
    final dto =  ImageDto.fromJson(json);

    if(dto.hits == null ){
      return [];
    }
    return dto.hits!.map((e) => e.toImageItem()).toList();
  }

}