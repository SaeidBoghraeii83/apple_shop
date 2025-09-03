import 'package:apple_shop/screens/bestseller_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/navigationbar_screen.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/screens/profilescreen.dart';
import 'package:apple_shop/screens/shoppingbasket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Main_Screen(),
      ),
    );
  }
}
