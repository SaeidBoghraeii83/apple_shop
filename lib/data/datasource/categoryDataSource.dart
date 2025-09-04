import 'package:apple_shop/apiExeption/ApiExeption.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/model/categoryModel.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get(); // بیس یو آر ال ای پی ای
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await _dio.get(
        'collections/category/records', // در خواست ریکوست به این دسته بندی
      );

      return response
          .data['items'] // تبدیل کردن مقادیر گرفته شده از سرور و جاگذاری
          .map<CategoryModel>(
            (jsonObject) => CategoryModel.formMapJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'خطا نامشخص');
    }
  }
}
