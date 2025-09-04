import 'package:apple_shop/apiExeption/ApiExeption.dart';
import 'package:apple_shop/data/datasource/categoryDataSource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/model/categoryModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategoryData();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource = locator
      .get(); // گرفتن دیتا از کلاس بالا دست ریموت
  @override
  Future<Either<String, List<CategoryModel>>> getCategoryData() async {
    try {
      var response = await _dataSource
          .getCategories(); // درخواست گرفتن دیتا از طریق این آدرس
      return right(response);
    } on DioError catch (e) {
      return left(ApiException(e.response?.statusCode, e.message).toString());
    } catch (e) {
      return left('خطا نامشخص');
    }
  }
}
