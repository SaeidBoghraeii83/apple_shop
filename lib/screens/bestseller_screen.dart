import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestsellerScreen extends StatelessWidget {
  const BestsellerScreen({super.key});

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
              sliver: _getItemBestSeller(),
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
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/search.png'),

          Text(
            'پر فروش ترین ها',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'SM',
              fontWeight: FontWeight.w700,
              color: Colors.indigo,
            ),
          ),
          Image.asset('images/icon_back.png'),
        ],
      ),
    ),
  );
}

//=============================

Widget _getCardItemBestSeller() {
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
                    child: Image.asset('images/active_fav_product.png'),
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
                    child: Image.asset('images/icon_right_arrow_cricle.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//==================
Widget _getItemBestSeller() {
  // گرفتن محصولات دسته بندی
  return SliverGrid.builder(
    itemCount: 20,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 10,
      childAspectRatio: 0.8,
    ),
    itemBuilder: (context, index) {
      return _getCardItemBestSeller();
    },
  );
}
