import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 15.w,
                vertical: 10,
              ),
              sliver: _getCategoryItem(),
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

Widget _getCategoryItem() {
  // گرفتن محصولات دسته بندی
  return SliverGrid.builder(
    itemCount: 20,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
    ),
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(15.r),
        ),
      );
    },
  );
}
