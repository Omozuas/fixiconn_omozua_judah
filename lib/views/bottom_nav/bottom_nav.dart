// ignore_for_file: deprecated_member_use

import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/controller/bottom_nav_controllers.dart';
import 'package:fixiconn/views/bottom_nav/widgets/upload_button.dart';
import 'package:fixiconn/views/main_view/mini_app_screen.dart';
import 'package:fixiconn/views/tap_screen/view_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pages = [
    const ViewScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavControllers());
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            pages[controller.tabsIndex],
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: appBlack, splashFactory: NoSplash.splashFactory),
          child: BottomNavigationBar(
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: white,
            unselectedItemColor: iconTextColor,
            selectedLabelStyle: appStyle(10, white, FontWeight.w500),
            unselectedLabelStyle: appStyle(10, iconTextColor, FontWeight.w500),
            onTap: (value) {},
            currentIndex: controller.tabsIndex,
            items: [
              BottomNavigationBarItem(
                  icon: GestureDetector(
                    onTap: () {
                      Get.to(() => const MiniAppScreen());
                    },
                    child: SvgPicture.asset(
                      'assets/icons/layer.svg',
                      color: iconTextColor,
                    ),
                  ),
                  label: 'Mini Apps'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/chat.svg',
                    color: controller.tabsIndex == 1 ? white : iconTextColor,
                  ),
                  label: 'Messages'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: const UploadButton(),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    color: controller.tabsIndex == 3 ? white : iconTextColor,
                  ),
                  label: 'Notifications'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    color: controller.tabsIndex == 4 ? white : iconTextColor,
                  ),
                  label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
