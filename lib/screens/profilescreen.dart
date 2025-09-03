import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 25.w,
                vertical: 10.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        left: 20,
                        child: Image.asset('images/icon_apple_blue.png'),
                      ),
                      Text(
                        'حساب کاربری',
                        style: TextStyle(
                          color: Color(0xff3B5EDF),
                          fontFamily: 'SM',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 30.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      ' Flutter Developer : سعید بقرائی',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SM',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      '+9809190073472',
                      style: TextStyle(
                        color: Color(0xff858585),
                        fontFamily: 'SM',
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
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
  }
}
