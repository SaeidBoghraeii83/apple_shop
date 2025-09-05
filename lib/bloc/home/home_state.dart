import 'package:apple_shop/model/bannerModel.dart';
import 'package:apple_shop/model/categoryModel.dart';
import 'package:apple_shop/model/productModel.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {} // وضعیت اغازین

class HomeLoadingState extends HomeState {} // وضعیت لودینگ قبل از دیتا

class HomeRequestSuccessState extends HomeState {
  // هر فرآیند درخواست زدن در این قسمته
  Either<String, List<BannerModel>> bannerList;
  Either<String, List<CategoryModel>> categoryList;
  Either<String, List<ProductModel>> productList;
  Either<String, List<ProductModel>> hotestProductList;

  Either<String, List<ProductModel>> bestsellerProductList;

  HomeRequestSuccessState(
    this.bannerList,
    this.categoryList,
    this.productList,
    this.bestsellerProductList,
    this.hotestProductList,
  );
}

/*

class HomeRequestHotestState extends HomeState {
  // تفکیک و جداسازی / جلوگیری از بزرگ تر شدن کلاس ساکسس
  Either<String, List<ProductModel>> hotestProductList;
  HomeRequestHotestState(this.hotestProductList);
}

class HomeRequestBestSellerState extends HomeState {
  // تفکیک و جداسازی / جلوگیری از بزرگ تر شدن کلاس ساکسس
  Either<String, List<ProductModel>> bestsellerProductList;
  HomeRequestBestSellerState(this.bestsellerProductList);
}

*/
