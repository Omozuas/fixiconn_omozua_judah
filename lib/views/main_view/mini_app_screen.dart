import 'dart:developer';

import 'package:fixiconn/apis/river_pod/get_game/get_all_random_game.dart';
import 'package:fixiconn/apis/river_pod/get_game/get_random_game.dart';
import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/main_view/widgets/categories_o_f_games.dart';
import 'package:fixiconn/views/main_view/widgets/custom_app_bar.dart';
import 'package:fixiconn/views/main_view/widgets/network_background_img.dart';
import 'package:fixiconn/views/main_view/widgets/recently_opened.dart';
import 'package:fixiconn/views/main_view/widgets/trending_games.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MiniAppScreen extends ConsumerStatefulWidget {
  const MiniAppScreen({super.key});

  @override
  ConsumerState<MiniAppScreen> createState() => _MiniAppScreenState();
}

class _MiniAppScreenState extends ConsumerState<MiniAppScreen> {
  AppTheme _currentTheme = AppTheme.light;

  void _toggleTheme() {
    setState(() {
      _currentTheme =
          _currentTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => loadGame());
    Future.microtask(() => loadAllGame());
  }

  void loadGame() async {
    try {
      await ref.read(getRandomGame.notifier).getRandomGame();
    } catch (e) {
      log('Error loading initial data: $e');
    }
  }

  void loadAllGame() async {
    log(' ....');
    try {
      await ref.read(getAllRandomGame.notifier).getAllRandomGame();
    } catch (e) {
      log('Error loading initial data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final game1 = ref.watch(getRandomGame);
    final game2 = ref.watch(getAllRandomGame);
    return RefreshIndicator(
      onRefresh: () async {
        loadGame();
        loadAllGame();
      },
      child: Scaffold(
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
                      height: 125.h,
                      child: game1.when(
                        skipLoadingOnRefresh: true,
                        skipLoadingOnReload: true,
                        data: (data) {
                          final v = data?.randomResturent ?? [];
                          return ListView.builder(
                            itemCount: v.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              final item = v[i];
                              return TrendingGames(
                                url: item.gameUrl ?? '',
                                name: item.gameName ?? '',
                                onTap: () {},
                                currentTheme: _currentTheme,
                              );
                            },
                          );
                        },
                        error: (e, s) {
                          return Shimmer.fromColors(
                            baseColor: white,
                            highlightColor: skyBlue.withOpacity(0.1),
                            child: TrendingGames(
                              url:
                                  'https://s3-alpha-sig.figma.com/img/18b4/4835/e7fce32aa2d764364a7a7c045879c343?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MZj3YGDS6o4ReRCLT2YttzmVO7GaueMCr2DG7UGGM-eozU8JhC8kb6rGr3GwuV52CV4An6xzA3Y4zLaou5dXPjNwHJxMGu0ce-85SQotEsbb5YgGYMppmOO2ZkO8W5yeOrQIZ2Jq6DjvaZ9oBs0chK3a~uWnQoWUzAxzsAcuZtDtXk4eYJrVTcIcHepA43Bj81X7TP8yx6sgWFIt08cZJCwLi3e~YUhnsm9AON4546m9dErBUF5nH4S9vS1qBKTs9WYsqyrbNyH-SZ0RRO2v~HCAOMPwopVEv2Wsl417GvdP8Gq0xvEy17cJGV7InAkDUGlLSvwfm9biRPUQucf-1w__',
                              name: '.....',
                              onTap: () {},
                              currentTheme: _currentTheme,
                            ),
                          );
                        },
                        loading: () => Shimmer.fromColors(
                          baseColor: white,
                          highlightColor: skyBlue.withOpacity(0.1),
                          child: TrendingGames(
                            url:
                                'https://s3-alpha-sig.figma.com/img/18b4/4835/e7fce32aa2d764364a7a7c045879c343?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MZj3YGDS6o4ReRCLT2YttzmVO7GaueMCr2DG7UGGM-eozU8JhC8kb6rGr3GwuV52CV4An6xzA3Y4zLaou5dXPjNwHJxMGu0ce-85SQotEsbb5YgGYMppmOO2ZkO8W5yeOrQIZ2Jq6DjvaZ9oBs0chK3a~uWnQoWUzAxzsAcuZtDtXk4eYJrVTcIcHepA43Bj81X7TP8yx6sgWFIt08cZJCwLi3e~YUhnsm9AON4546m9dErBUF5nH4S9vS1qBKTs9WYsqyrbNyH-SZ0RRO2v~HCAOMPwopVEv2Wsl417GvdP8Gq0xvEy17cJGV7InAkDUGlLSvwfm9biRPUQucf-1w__',
                            name: '.....',
                            onTap: () {},
                            currentTheme: _currentTheme,
                          ),
                        ),
                      ),
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
                      child: game2.when(
                        skipLoadingOnRefresh: true,
                        skipLoadingOnReload: true,
                        data: (data) {
                          final item = data?.randomResturent ?? [];
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // 3 items per row
                                    crossAxisSpacing:
                                        0.1, // Horizontal spacing between items
                                    mainAxisSpacing: width *
                                        0.4, // Vertical spacing between rows
                                    mainAxisExtent: 190),
                            itemCount: item.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              final v = item[i];
                              return CategoriesOFGames(
                                name: v.gameName ?? '',
                                url: v.gameUrl ?? '',
                                onTap: () {},
                                currentTheme: _currentTheme,
                              );
                            },
                          );
                        },
                        error: (e, s) {
                          return Shimmer.fromColors(
                            baseColor: white,
                            highlightColor: skyBlue.withOpacity(0.1),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, // 3 items per row
                                      crossAxisSpacing:
                                          0.1, // Horizontal spacing between items
                                      mainAxisSpacing: width *
                                          0.4, // Vertical spacing between rows
                                      mainAxisExtent: 190),
                              itemCount: 3,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return CategoriesOFGames(
                                  name: '......',
                                  url:
                                      'https://s3-alpha-sig.figma.com/img/18b4/4835/e7fce32aa2d764364a7a7c045879c343?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MZj3YGDS6o4ReRCLT2YttzmVO7GaueMCr2DG7UGGM-eozU8JhC8kb6rGr3GwuV52CV4An6xzA3Y4zLaou5dXPjNwHJxMGu0ce-85SQotEsbb5YgGYMppmOO2ZkO8W5yeOrQIZ2Jq6DjvaZ9oBs0chK3a~uWnQoWUzAxzsAcuZtDtXk4eYJrVTcIcHepA43Bj81X7TP8yx6sgWFIt08cZJCwLi3e~YUhnsm9AON4546m9dErBUF5nH4S9vS1qBKTs9WYsqyrbNyH-SZ0RRO2v~HCAOMPwopVEv2Wsl417GvdP8Gq0xvEy17cJGV7InAkDUGlLSvwfm9biRPUQucf-1w__',
                                  onTap: () {},
                                  currentTheme: _currentTheme,
                                );
                              },
                            ),
                          );
                        },
                        loading: () => Shimmer.fromColors(
                          baseColor: white,
                          highlightColor: skyBlue.withOpacity(0.1),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // 3 items per row
                                    crossAxisSpacing:
                                        0.1, // Horizontal spacing between items
                                    mainAxisSpacing: width *
                                        0.4, // Vertical spacing between rows
                                    mainAxisExtent: 190),
                            itemCount: 3,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return CategoriesOFGames(
                                name: '......',
                                url:
                                    'https://s3-alpha-sig.figma.com/img/18b4/4835/e7fce32aa2d764364a7a7c045879c343?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MZj3YGDS6o4ReRCLT2YttzmVO7GaueMCr2DG7UGGM-eozU8JhC8kb6rGr3GwuV52CV4An6xzA3Y4zLaou5dXPjNwHJxMGu0ce-85SQotEsbb5YgGYMppmOO2ZkO8W5yeOrQIZ2Jq6DjvaZ9oBs0chK3a~uWnQoWUzAxzsAcuZtDtXk4eYJrVTcIcHepA43Bj81X7TP8yx6sgWFIt08cZJCwLi3e~YUhnsm9AON4546m9dErBUF5nH4S9vS1qBKTs9WYsqyrbNyH-SZ0RRO2v~HCAOMPwopVEv2Wsl417GvdP8Gq0xvEy17cJGV7InAkDUGlLSvwfm9biRPUQucf-1w__',
                                onTap: () {},
                                currentTheme: _currentTheme,
                              );
                            },
                          ),
                        ),
                      ),
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
                      height: 125.h,
                      child: game1.when(
                        skipLoadingOnRefresh: true,
                        skipLoadingOnReload: true,
                        data: (data) {
                          final item = data?.randomResturent ?? [];
                          return ListView.builder(
                            itemCount: item.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              final v = item[i];
                              return RecentlyOpened(
                                url: v.gameUrl ?? ' ',
                                name: v.gameName ?? ' ',
                                onTap: () {},
                                currentTheme: _currentTheme,
                              );
                            },
                          );
                        },
                        error: (e, s) {
                          return Shimmer.fromColors(
                            baseColor: white,
                            highlightColor: skyBlue.withOpacity(0.1),
                            child: ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return RecentlyOpened(
                                  url:
                                      'https://s3-alpha-sig.figma.com/img/18b4/4835/e7fce32aa2d764364a7a7c045879c343?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MZj3YGDS6o4ReRCLT2YttzmVO7GaueMCr2DG7UGGM-eozU8JhC8kb6rGr3GwuV52CV4An6xzA3Y4zLaou5dXPjNwHJxMGu0ce-85SQotEsbb5YgGYMppmOO2ZkO8W5yeOrQIZ2Jq6DjvaZ9oBs0chK3a~uWnQoWUzAxzsAcuZtDtXk4eYJrVTcIcHepA43Bj81X7TP8yx6sgWFIt08cZJCwLi3e~YUhnsm9AON4546m9dErBUF5nH4S9vS1qBKTs9WYsqyrbNyH-SZ0RRO2v~HCAOMPwopVEv2Wsl417GvdP8Gq0xvEy17cJGV7InAkDUGlLSvwfm9biRPUQucf-1w__',
                                  name: '... ',
                                  onTap: () {},
                                  currentTheme: _currentTheme,
                                );
                              },
                            ),
                          );
                        },
                        loading: () => Shimmer.fromColors(
                          baseColor: white,
                          highlightColor: skyBlue.withOpacity(0.1),
                          child: ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return RecentlyOpened(
                                url:
                                    'https://s3-alpha-sig.figma.com/img/18b4/4835/e7fce32aa2d764364a7a7c045879c343?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MZj3YGDS6o4ReRCLT2YttzmVO7GaueMCr2DG7UGGM-eozU8JhC8kb6rGr3GwuV52CV4An6xzA3Y4zLaou5dXPjNwHJxMGu0ce-85SQotEsbb5YgGYMppmOO2ZkO8W5yeOrQIZ2Jq6DjvaZ9oBs0chK3a~uWnQoWUzAxzsAcuZtDtXk4eYJrVTcIcHepA43Bj81X7TP8yx6sgWFIt08cZJCwLi3e~YUhnsm9AON4546m9dErBUF5nH4S9vS1qBKTs9WYsqyrbNyH-SZ0RRO2v~HCAOMPwopVEv2Wsl417GvdP8Gq0xvEy17cJGV7InAkDUGlLSvwfm9biRPUQucf-1w__',
                                name: '... ',
                                onTap: () {},
                                currentTheme: _currentTheme,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum AppTheme { light, dark }
