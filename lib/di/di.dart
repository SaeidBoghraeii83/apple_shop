import 'package:apple_shop/data/datasource/bannerDataSource.dart';
import 'package:apple_shop/data/datasource/categoryDataSource.dart';
import 'package:apple_shop/data/datasource/productDataSource.dart';
import 'package:apple_shop/repository/banner_repository.dart';
import 'package:apple_shop/repository/category_repository.dart';
import 'package:apple_shop/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')), // بیس یو آر ال
  ); // ریکوست بزن به این );

  locator.registerFactory<ICategoryDataSource>(
    () => CategoryRemoteDataSource(),
  );

  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerdatasource>(() => BannerRemoteDataSource());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductdatasource>(() => ProductRemotedatasource());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
}
