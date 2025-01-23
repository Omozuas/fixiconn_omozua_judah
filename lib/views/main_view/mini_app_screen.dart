import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/db/dummydata.dart';
import 'package:fixiconn/views/main_view/widgets/categories_o_f_games.dart';
import 'package:fixiconn/views/main_view/widgets/custom_app_bar.dart';
import 'package:fixiconn/views/main_view/widgets/network_background_img.dart';
import 'package:fixiconn/views/main_view/widgets/recently_opened.dart';
import 'package:fixiconn/views/main_view/widgets/trending_games.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniAppScreen extends StatefulWidget {
  const MiniAppScreen({super.key});

  @override
  State<MiniAppScreen> createState() => _MiniAppScreenState();
}

class _MiniAppScreenState extends State<MiniAppScreen> {
  AppTheme _currentTheme = AppTheme.light;

  void _toggleTheme() {
    setState(() {
      _currentTheme =
          _currentTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _currentTheme == AppTheme.light ? white : appBlack.withOpacity(0.5),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                NetworkBackgroundImg(
                  currentTheme: _currentTheme,
                ),
                Positioned(
                  top: height * 0.05,
                  right: 0,
                  left: 0,
                  child: CustomAppBar(
                    onTap: _toggleTheme,
                    currentTheme: _currentTheme,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    text: 'Trending',
                    style: appStyle(
                        14,
                        _currentTheme == AppTheme.light ? appBlack : white,
                        FontWeight.w700),
                  ),
                  ReuseableText(
                    text: 'Trending games from 30 days',
                    style: appStyle(
                        12,
                        _currentTheme == AppTheme.light ? appBlack : white,
                        FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 120.h,
                    child: ListView.builder(
                        itemCount: games.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          final item = games[i];
                          return TrendingGames(
                            item: item,
                            onTap: () {},
                            currentTheme: _currentTheme,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReuseableText(
                    text: 'Categories',
                    style: appStyle(
                        14,
                        _currentTheme == AppTheme.light ? appBlack : white,
                        FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 230.h,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 items per row
                            crossAxisSpacing:
                                0.1, // Horizontal spacing between items
                            mainAxisSpacing:
                                width * 0.4, // Vertical spacing between rows
                            mainAxisExtent: 190),
                        itemCount: games.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          final item = games[i];
                          return CategoriesOFGames(
                            item: item,
                            onTap: () {},
                            currentTheme: _currentTheme,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReuseableText(
                    text: 'Recently Opened',
                    style: appStyle(
                        14,
                        _currentTheme == AppTheme.light ? appBlack : white,
                        FontWeight.w700),
                  ),
                  ReuseableText(
                    text: 'Here are some of your recently played games',
                    style: appStyle(
                        12,
                        _currentTheme == AppTheme.light ? appBlack : white,
                        FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 120.h,
                    child: ListView.builder(
                        itemCount: games.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          final item = games[i];
                          return RecentlyOpened(
                            item: item,
                            onTap: () {},
                            currentTheme: _currentTheme,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AppTheme { light, dark }
