import 'package:apple_shop/apiExeption/ApiExeption.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/model/bannerModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class IBannerdatasource {
  Future<List<BannerModel>> getBanner();
}

class BannerRemoteDataSource extends IBannerdatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<BannerModel>> getBanner() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response
          .data['items'] // تبدیل کردن مقادیر گرفته شده از سرور و جاگذاری
          .map<BannerModel>((jsonObject) => BannerModel.formMapJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطا در ارتباط با سرور');
    }
  }
}
