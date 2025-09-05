import 'package:apple_shop/apiExeption/ApiExeption.dart';
import 'package:apple_shop/data/datasource/productDataSource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/model/productModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IProductRepository {
  Future<Either<String, List<ProductModel>>> getProduct();
  Future<Either<String, List<ProductModel>>> getHotest();
  Future<Either<String, List<ProductModel>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductdatasource _productdatasource = locator.get();
  @override
  Future<Either<String, List<ProductModel>>> getProduct() async {
    try {
      var response = await _productdatasource.getProduct();
      return right(response);
    } on DioError catch (e) {
      return left(ApiException(e.response?.statusCode, e.message).toString());
    } catch (e) {
      return left('خطا نامشخص');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getBestSeller() async {
    try {
      var response = await _productdatasource.getBestSeller();
      return right(response);
    } on DioError catch (e) {
      return left(ApiException(e.response?.statusCode, e.message).toString());
    } catch (e) {
      return left('خطا نامشخص');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getHotest() async {
    try {
      var response = await _productdatasource.getHotest();
      return right(response);
    } on DioError catch (e) {
      return left(ApiException(e.response?.statusCode, e.message).toString());
    } catch (e) {
      return left('خطا نامشخص');
    }
  }
}
