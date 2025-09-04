import 'package:flutter/cupertino.dart';

class BannerModel {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;

  BannerModel(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory BannerModel.formMapJson(Map<String, dynamic> jsonObject) {
    return BannerModel(
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}', // گرفتن بنر از سرور
    );
  }
}
