import 'package:apple_shop/model/categoryModel.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  Either<String, List<CategoryModel>> response;
  CategoryResponseState(this.response);
}

class CategoryLoadingState extends CategoryState {
  // اضافه کردن لودینگ قبل از اومدن دیتا
}
