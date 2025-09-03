import 'package:apple_shop/screens/bestseller_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bannerController = PageController(viewportFraction: 0.9);
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
            SliverToBoxAdapter(child: _getBannerSlider(bannerController)),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 25.w,
                vertical: 7.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Text(
                    'دسته بندی',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
              sliver: SliverToBoxAdapter(child: _getCategoryItem()),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 17.w,
                vertical: 8.h,
              ),
              sliver: SliverToBoxAdapter(child: _getBestSellerItem()),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
              sliver: SliverToBoxAdapter(child: _getProductHomeItem()),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 17.w,
                vertical: 15.h,
              ),
              sliver: SliverToBoxAdapter(child: _getMostVisited()),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
              sliver: SliverToBoxAdapter(child: _getProductHomeItem()),
            ),
          ],
        ),
      ),
    );
  }
}
//============================================

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
      child: Row(
        children: [
          Image.asset('images/icon_apple_blue.png'),
          Spacer(),
          Row(
            children: [
              Text(
                'جستجوی محصولات',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'SM',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff858585),
                ),
              ),
              SizedBox(width: 7.w),
              Image.asset('images/icon_search.png'),
            ],
          ),
        ],
      ),
    ),
  );
}

//======================================

Widget _getBannerSlider(PageController bannerController) {
  // گرفتن بنر اسلایدر
  var count = 5;

  return Stack(
    alignment: AlignmentGeometry.bottomCenter,
    children: [
      SizedBox(
        height: 177,
        child: PageView.builder(
          itemCount: count,
          controller: bannerController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(9),
              child: Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
      Positioned(
        bottom: 17,
        child: SmoothPageIndicator(
          controller: bannerController,
          count: 6,
          axisDirection: Axis.horizontal,
          effect: ExpandingDotsEffect(
            dotColor: Colors.white,
            activeDotColor: Colors.indigoAccent,

            expansionFactor: 6,
            dotHeight: 6,
            dotWidth: 6,
          ),
        ),
      ),
    ],
  );
}

//===============================

Widget _getCategoryItem() {
  // گرفتن ایتم های دسته بندی
  return Column(
    children: [
      SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: 50.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'همه',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

//==============================
Widget _getBestSellerItem() {
  // گرفتن پر فروش ترین ها
  return Row(
    children: [
      Row(
        children: [
          Image.asset('images/icon_left_categroy.png'),
          SizedBox(width: 10),
          InkWell(
            onTap: () => BestsellerScreen(),
            child: Text(
              'مشاهده همه',
              style: TextStyle(
                color: Colors.indigo,
                fontFamily: 'SM',
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
      Spacer(),
      Text(
        'پر فروش ترین ها',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'SM',
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

//===================================

Widget _getProductHomeItem() {
  //گرفتن محصولات  صفحه اصلی
  return Column(
    children: [
      SizedBox(
        height: 255,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 150.w,
                height: 160.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),

                        height: 170,
                        width: double.infinity,

                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 52,
                              child: Image.asset('images/iphone.png'),
                            ),
                            Positioned(
                              top: 6,
                              right: 8,
                              child: Image.asset(
                                'images/active_fav_product.png',
                              ),
                            ),
                            Positioned(
                              bottom: 35,
                              left: 13,
                              child: Container(
                                width: 30,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '%3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SM',
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 10.r,
                              child: Text(
                                'آیفون 13 پرو مکس',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'تومان',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SM',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '5,350,000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SM',
                                  ),
                                ),
                                Text(
                                  '16,340,000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SM',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                              width: 25.w,
                              child: Image.asset(
                                'images/icon_right_arrow_cricle.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

// ======================================================

Widget _getMostVisited() {
  return Row(
    children: [
      Row(
        children: [
          Image.asset('images/icon_left_categroy.png'),
          SizedBox(width: 10),
          Text(
            'پر بازدید ترین',
            style: TextStyle(
              color: Colors.indigo,
              fontFamily: 'SM',
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
      Spacer(),
      Text(
        'پر فروش ترین ها',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'SM',
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
