import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/model/bannerModel.dart';
import 'package:apple_shop/model/categoryModel.dart';
import 'package:apple_shop/screens/bestseller_screen.dart';
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
            return CustomScrollView(
              slivers: [
                if (state is HomeLoadingState) ...[
                  SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
                _getSearchBox(),
                if (state is HomeRequestSuccessState) ...[
                  state.bannerList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(child: Text(errorMessage));
                    },
                    (BannerData) {
                      return SliverToBoxAdapter(
                        child: BannerSlider(list: BannerData),
                      );
                    },
                  ),
                ],
                _getTextCategory(),
                if (state is HomeRequestSuccessState) ...[
                  state.categoryList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(child: Text(errorMessage));
                    },
                    (categoryList) {
                      return SliverToBoxAdapter(
                        child: CategoryProduct(categoryList: categoryList),
                      );
                    },
                  ),
                ],
                _getBestSeller(),
                _getProductHome(),
                __getMostVisited(),
                _getProductHome(),
              ],
            );
          },
        ),
      ),
    );
  }
}

//========================================= ویجت ها

class __getMostVisited extends StatelessWidget {
  const __getMostVisited({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 17.w, vertical: 15.h),
      sliver: SliverToBoxAdapter(child: _getMostVisited()),
    );
  }
}

class _getProductHome extends StatelessWidget {
  const _getProductHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
      sliver: SliverToBoxAdapter(child: _getProductHomeItem()),
    );
  }
}

class _getBestSeller extends StatelessWidget {
  const _getBestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 17.w, vertical: 8.h),
      sliver: SliverToBoxAdapter(child: _getBestSellerItem(context)),
    );
  }
}

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
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w, vertical: 15.h),
      sliver: SliverToBoxAdapter(child: _getAppBar()),
    );
  }
}

//========================================= ویجت ها

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
          height: 177,
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
                            width: 25.w,
                            height: 20.h,
                            child: CashedImage(
                              imageUrl: categoryList[index].icon ?? 'error',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      categoryList[index].title ?? '',
                      style: const TextStyle(
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
  return Row(
    children: [
      Row(
        children: [
          Image.asset('images/icon_left_categroy.png'),
          SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => BestsellerScreen())),
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
