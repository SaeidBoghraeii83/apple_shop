import 'package:apple_shop/bloc/category_Bloc/category_event.dart';
import 'package:apple_shop/bloc/category_Bloc/category_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryRequestList>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategoryData();
      emit(CategoryResponseState(response)); // جایگذاری دیتا آماده
    });
  }
}
