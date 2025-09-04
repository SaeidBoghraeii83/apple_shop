import 'dart:math';

import 'package:apple_shop/bloc/category_Bloc/category_bloc.dart';
import 'package:apple_shop/bloc/category_Bloc/category_event.dart';
import 'package:apple_shop/bloc/category_Bloc/category_state.dart';
import 'package:apple_shop/model/categoryModel.dart';
import 'package:apple_shop/widget/cashed_Image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              sliver: SliverToBoxAdapter(child: _getAppBar()),
            ),

            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.response.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(errorMessage)),
                      );
                    },
                    (l) {
                      return ListCategory(list: l);
                    },
                  );
                } else {
                  return SliverToBoxAdapter(child: Text('error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getAppBar() {
  // اپ بار صفحه اصلی
  return Container(
    height: 45.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Padding(
      padding: const EdgeInsets.all(11),
      child: Stack(
        children: [
          Positioned(
            left: 5,
            top: 5,
            child: Image.asset('images/icon_apple_blue.png'),
          ),

          Positioned(
            left: 140,
            top: 5,
            child: Text(
              'دسته بندی',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'SM',
                fontWeight: FontWeight.w700,
                color: Color(0xff858585),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//================================

class ListCategory extends StatelessWidget {
  final List<CategoryModel>? list;
  const ListCategory({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(((context, index) {
          return CashedImage(imageUrl: list?[index].thumbnail ?? 'test');
        }), childCount: list?.length ?? 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
