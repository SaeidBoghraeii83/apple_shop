import 'package:apple_shop/model/bannerModel.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {} // وضعیت اغازین

class HomeLoadingState extends HomeState {} // وضعیت لودینگ قبل از دیتا

class HomeRequestSuccessState extends HomeState {
  // هر فرآیند درخواست زدن در این قسمته
  Either<String, List<BannerModel>> bannerList;
  HomeRequestSuccessState(this.bannerList);
}
