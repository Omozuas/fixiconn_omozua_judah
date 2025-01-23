// ignore_for_file: deprecated_member_use

import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/tap_screen/following_screen.dart';
import 'package:fixiconn/views/tap_screen/for_you_screen.dart';
import 'package:fixiconn/views/tap_screen/live_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: 2); //nitialize TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: blue,
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: const [LiveScreen(), FollowingScreen(), ForYouScreen()],
          ),
          Positioned(
            top: 50,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/menu.svg',
                            ),
                          )
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 3,
                      initialIndex: 2,
                      child: Column(
                        children: [
                          TabBar(
                            tabAlignment: TabAlignment.center,
                            indicatorWeight: 1,
                            indicatorSize: TabBarIndicatorSize.label,
                            dividerColor: Colors.transparent,
                            indicatorColor: white,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding:
                                EdgeInsets.only(left: 20.w, right: 20.w),
                            labelStyle: appStyle(12, white, FontWeight.w500),
                            controller: _tabController,
                            tabs: [
                              ReuseableText(
                                text: 'LIVE',
                                style: appStyle(12, white, FontWeight.w500),
                              ),
                              ReuseableText(
                                text: 'Following',
                                style: appStyle(12, white, FontWeight.w500),
                              ),
                              ReuseableText(
                                text: 'For You',
                                style: appStyle(12, white, FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
