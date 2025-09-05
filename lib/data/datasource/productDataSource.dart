import 'package:apple_shop/apiExeption/ApiExeption.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/model/productModel.dart';
import 'package:dio/dio.dart';

abstract class IProductdatasource {
  Future<List<ProductModel>> getProduct();
  Future<List<ProductModel>> getHotest();
  Future<List<ProductModel>> getBestSeller();
}

class ProductRemotedatasource extends IProductdatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductModel>> getProduct() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response
          .data['items'] // تبدیل کردن مقادیر گرفته شده از سرور و جاگذاری
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطا در برقراری ارتباط  با سرور');
    }
  }

  @override
  Future<List<ProductModel>> getBestSeller() async {
    try {
      Map<String, String> qParams = {
        'filter': 'popularity="Best Seller"',
      }; // دستور پارامت برای گرفتن پر فروش ترین ها
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
      return response
          .data['items'] // تبدیل کردن مقادیر گرفته شده از سرور و جاگذاری
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطا در برقراری ارتباط  با سرور');
    }
  }

  @override
  Future<List<ProductModel>> getHotest() async {
    try {
      Map<String, String> qParams = {
        'filter': 'popularity="Hotest"',
      }; // دستور پارامت برای گرفتن پر بازدید ترین ها
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );

      return response
          .data['items'] // تبدیل کردن مقادیر گرفته شده از سرور و جاگذاری
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطا در برقراری ارتباط  با سرور');
    }
  }
}
