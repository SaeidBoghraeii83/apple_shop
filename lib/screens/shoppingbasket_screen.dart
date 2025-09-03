import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Shopping_Basket extends StatelessWidget {
  const Shopping_Basket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 25.w,
                    vertical: 10.h,
                  ),
                  sliver: SliverToBoxAdapter(child: _getAppbarBasket()),
                ),
                SliverPadding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 22.w,
                    vertical: 4.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return _getBasketCard();
                    }, childCount: 5),
                  ),
                ),
                SliverPadding(padding: EdgeInsetsGeometry.only(bottom: 45)),
              ],
            ),

            _getBasketButton(), // دکمه سبد خرید
          ],
        ),
      ),
    );
  }

  Widget _getBasketButton() {
    // دکمه سبد خرید
    return Padding(
      padding: const EdgeInsets.all(17),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 45.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18.r),
            ), // This removes the border radius
          ),
          backgroundColor: Colors.teal,
        ),
        onPressed: () {},
        child: Text(
          'ادامه فرایند خرید',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            fontFamily: 'SM',
          ),
        ),
      ),
    );
  }

  Widget _getBasketCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        width: 340,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              right: 10,
              top: 25,
              child: Image.asset('images/iphone.png'),
            ),

            Positioned(
              top: 25,
              left: 15,
              child: Container(
                width: 212,
                height: 170,
                child: _getItemProduct(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
            ),
            Positioned(bottom: 30, child: _getPriceProduct()),
          ],
        ),
      ),
    );
  }

  Widget _getPriceProduct() {
    return Row(
      children: [
        Text(
          'تومان',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SM',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          ' ۴۵٬۳۵۰٬۰۰۰ ',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SM',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _getItemProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [_getTititleAndSubtitleProduct(), SizedBox(height: 10)],
        ),
        _getPriceAndDiscountProduct(),
        SizedBox(height: 10),
        _getDetailsItemProduct(),
        SizedBox(height: 10),
        _getControllDetailsProduct(),
      ],
    );
  }
}

Widget _getTititleAndSubtitleProduct() {
  // گرفتن تایتل و ساب تایتل محصول
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 1),
        child: Text(
          'آیفون ۱۳ پرومکس دوسیم کارت ',
          style: TextStyle(
            fontFamily: 'SM',
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),

      SizedBox(height: 10.h),
      Text(
        'گارانتی 18 ماه مدیا پردازش',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,

        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10.sp,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
          fontFamily: 'SM',
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget _getPriceAndDiscountProduct() {
  //گرفتن قیمت محصول و تخفیف
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        width: 29.w,
        height: 14.h,
        child: Text(
          textAlign: TextAlign.center,
          '%3',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SM',
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(width: 8),
      Text(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        'تومان',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'SM',

          color: Colors.black,
        ),
      ),
      Text(
        '  ۴۶٬۰۰۰٬۰۰۰',

        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'SM',
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget _getDetailsItemProduct() {
  //گرفتن جزِیات محصول
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 94.w,
        height: 24.h,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('images/icon_options.png'),
            Text(
              'سبز کله غازی',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SM',
                fontSize: 9.sp,
              ),
            ),
            Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 8),
      Container(
        width: 80.w,
        height: 24.h,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('images/icon_options.png'),

              Text(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                '256 گیگابایت',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SM',
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _getControllDetailsProduct() {
  // گرفتن کنترلر محصولات
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        width: 59.w,
        height: 24.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              'حذف',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SM',
                fontSize: 9.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
              width: 15.w,
              child: Image.asset('images/icon_trash.png'),
            ),
          ],
        ),
      ),
      SizedBox(width: 10.w),
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        width: 59.w,
        height: 24.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              'ذخیره',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SM',
                fontSize: 9.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
              width: 15.w,
              child: Image.asset('images/active_fav_product.png'),
            ),
          ],
        ),
      ),
      SizedBox(width: 10.w),
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        width: 45.w,
        height: 24.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('images/icon_options.png'),
            Text(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              '۱',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SM',
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _getAppbarBasket() {
  return Container(
    height: 36.h,
    decoration: BoxDecoration(
      color: Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(left: 20, child: Image.asset('images/icon_apple_blue.png')),
        Text(
          'سبد خرید',
          style: TextStyle(
            color: Color(0xff3B5EDF),
            fontFamily: 'SM',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
