import 'package:apple_shop/apiExeption/ApiExeption.dart';
import 'package:apple_shop/data/datasource/bannerDataSource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/model/bannerModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerModel>>> getBannerData();
}

class BannerRepository extends IBannerRepository {
  final IBannerdatasource _dataSource = locator
      .get(); // گرفتن دیتا از کلاس بالا دست ریموت
  @override
  Future<Either<String, List<BannerModel>>> getBannerData() async {
    try {
      var response = await _dataSource.getBanner();
      return right(response);
    } on DioError catch (e) {
      return left(ApiException(e.response?.statusCode, e.message).toString());
    } catch (e) {
      return left('خطا در سرور');
    }
  }
}
