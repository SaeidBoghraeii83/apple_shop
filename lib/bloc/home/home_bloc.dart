import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/repository/banner_repository.dart';
import 'package:apple_shop/repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _repository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitilzeData>((event, emit) async {
      emit(HomeInitState());
      var bannerList = await _repository.getBannerData();
      var categoryList = await _categoryRepository.getCategoryData();
      emit(HomeRequestSuccessState(bannerList, categoryList));
    });
  }
}
