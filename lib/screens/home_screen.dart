import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/model/bannerModel.dart';
import 'package:apple_shop/model/categoryModel.dart';
import 'package:apple_shop/model/productModel.dart';
import 'package:apple_shop/screens/bestseller_screen.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/widget/cashed_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitilzeData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  ),
                ],
              );
            }

            if (state is HomeRequestSuccessState) {
              return CustomScrollView(
                slivers: [
                  _getSearchBox(),
                  SliverToBoxAdapter(
                    child: state.bannerList.fold(
                      (errorMessage) => Text(errorMessage),
                      (bannerData) => BannerSlider(list: bannerData),
                    ),
                  ),
                  _getTextCategory(),
                  SliverToBoxAdapter(
                    child: state.categoryList.fold(
                      (errorMessage) => Text(errorMessage),
                      (categoryList) =>
                          CategoryProduct(categoryList: categoryList),
                    ),
                  ),
                  _getBestSellerItem(context),
                  SliverToBoxAdapter(
                    child: state.bestsellerProductList.fold(
                      (errorMessage) => Text(errorMessage),
                      (productBestSellerList) => Product_BestSeller(
                        productBestseller: productBestSellerList,
                      ),
                    ),
                  ),
                  _getTextMostVisited(),
                  SliverToBoxAdapter(
                    child: state.hotestProductList.fold(
                      (errorMessage) => Text(errorMessage),
                      (productHotestList) =>
                          Product_Hotest(productHotest: productHotestList),
                    ),
                  ),
                ],
              );
            }

            // حالت اولیه یا fallback
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

//========================================= ویجت ها

class _getTextCategory extends StatelessWidget {
  const _getTextCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w, vertical: 7.h),
      sliver: SliverToBoxAdapter(
        child: Align(
          alignment: AlignmentGeometry.bottomRight,
          child: Text(
            'دسته بندی',
            style: TextStyle(
              fontFamily: 'SM',
              color: Color(0xff858585),
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _getSearchBox extends StatelessWidget {
  const _getSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w, vertical: 8.h),
      sliver: SliverToBoxAdapter(
        child: Container(
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
        ),
      ),
    );
  }
}

//======================================
// قسمت گرفتن بنر از سرور
class BannerSlider extends StatelessWidget {
  final List<BannerModel>? list;
  var bannerController = PageController(viewportFraction: 0.9);
  BannerSlider({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            itemCount: list?.length,
            controller: bannerController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(9),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(15.r)),
                  child: CashedImage(
                    fit: BoxFit.cover,
                    imageUrl: list?[index].thumbnail ?? 'error data thumbnail',
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
            count: list?.length ?? 0,
            axisDirection: Axis.horizontal,
            effect: ExpandingDotsEffect(
              dotColor: Colors.white,
              activeDotColor: Colors.lightBlue,

              expansionFactor: 6,
              dotHeight: 6,
              dotWidth: 6,
            ),
          ),
        ),
      ],
    );
  }
}

//===============================

// گرفتن ایتم های دسته بندی
class CategoryProduct extends StatelessWidget {
  final List<CategoryModel> categoryList;

  const CategoryProduct({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        width: 52.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: _hexToColor(categoryList[index].color),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 20.h,
                            child: CashedImage(
                              fit: BoxFit.contain,
                              imageUrl: categoryList[index].icon ?? 'error',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      categoryList[index].title ?? '',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 11.sp,
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

  /// تبدیل استرینگ رنگ به Color
  Color _hexToColor(String? hex) {
    try {
      hex = hex?.replaceAll('#', '');
      if (hex == null || hex.isEmpty) return Colors.grey;

      return Color(int.parse('FF$hex', radix: 16)); // شفافیت + رنگ
    } catch (_) {
      return Colors.grey; // رنگ پیش‌فرض
    }
  }
}

//==============================
Widget _getBestSellerItem(BuildContext context) {
  // گرفتن پر فروش ترین ها
  return SliverPadding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 17.w, vertical: 8.h),
    sliver: SliverToBoxAdapter(
      child: Row(
        children: [
          Row(
            children: [
              Image.asset('images/icon_left_categroy.png'),
              SizedBox(width: 10),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BestsellerScreen()),
                ),
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
              color: Color(0xff858585),
              fontFamily: 'SM',
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

//===================================
// محصولات اصلی
class Product_Item extends StatelessWidget {
  List<ProductModel> product;
  Product_Item({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.length,
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
                                top: 27,
                                left: 40,
                                child: SizedBox(
                                  height: 78.h,
                                  width: 80.w,
                                  child: CashedImage(
                                    fit: BoxFit.contain,
                                    imageUrl: product[index].thumbnail,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 12,
                                child: Image.asset(
                                  'images/active_fav_product.png',
                                ),
                              ),
                              Positioned(
                                bottom: 35,
                                left: 10,
                                child: Container(
                                  width: 25,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '${product[index].persent!.round().toString()} ٪',
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
                                bottom: 10,
                                right: 13.r,
                                child: Text(
                                  product[index].name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'SM',
                                    fontWeight: FontWeight.w700,
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
                            color: const Color.fromARGB(255, 65, 94, 255),
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
                                    product[index].price.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'sm',
                                      fontSize: 12,
                                      color: Colors.white,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    product[index].realPrice.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'sm',
                                      fontSize: 16,
                                      color: Colors.white,
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
}

// ======================================================
// پر بازدید ترین ها
Widget _getTextMostVisited() {
  return SliverPadding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 17.w, vertical: 8.h),
    sliver: SliverToBoxAdapter(
      child: Row(
        children: [
          Row(
            children: [
              Image.asset('images/icon_left_categroy.png'),
              SizedBox(width: 10),
              Text(
                'مشاهده همه',
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
            'پر بازدید ترین ها',
            style: TextStyle(
              color: Color(0xff858585),
              fontFamily: 'SM',
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

//================================

//==================================
// قسمت پر فروش ترین ها

class Product_BestSeller extends StatelessWidget {
  List<ProductModel> productBestseller;
  Product_BestSeller({super.key, required this.productBestseller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productBestseller.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Product_Detail_Screen(),
                    ),
                  ),
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
                                  top: 27,
                                  left: 40,
                                  child: SizedBox(
                                    height: 78.h,
                                    width: 80.w,
                                    child: CashedImage(
                                      fit: BoxFit.contain,
                                      imageUrl:
                                          productBestseller[index].thumbnail,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 12,
                                  child: Image.asset(
                                    'images/active_fav_product.png',
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  left: 10,
                                  child: Container(
                                    width: 25,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      '${productBestseller[index].persent!.round().toString()} ٪',
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
                                  bottom: 10,
                                  right: 13.r,
                                  child: Text(
                                    productBestseller[index].name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'SM',
                                      fontWeight: FontWeight.w700,
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
                              color: const Color.fromARGB(255, 65, 94, 255),
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
                                      productBestseller[index].price.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 12,
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      productBestseller[index].realPrice
                                          .toString(),
                                      style: const TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 16,
                                        color: Colors.white,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

//محصولات پر بازدید ترین

class Product_Hotest extends StatelessWidget {
  List<ProductModel> productHotest;
  Product_Hotest({super.key, required this.productHotest});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productHotest.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Product_Detail_Screen(),
                    ),
                  ),
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
                                  top: 27,
                                  left: 40,
                                  child: SizedBox(
                                    height: 78.h,
                                    width: 80.w,
                                    child: CashedImage(
                                      fit: BoxFit.contain,
                                      imageUrl: productHotest[index].thumbnail,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 12,
                                  child: Image.asset(
                                    'images/active_fav_product.png',
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  left: 10,
                                  child: Container(
                                    width: 25,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      '${productHotest[index].persent!.round().toString()} ٪',
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
                                  bottom: 10,
                                  right: 13.r,
                                  child: Text(
                                    productHotest[index].name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'SM',
                                      fontWeight: FontWeight.w700,
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
                              color: const Color.fromARGB(255, 65, 94, 255),
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
                                      productHotest[index].price.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 12,
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      productHotest[index].realPrice.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 16,
                                        color: Colors.white,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
