import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/background_container.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/onbording_screens/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SlpashScreen extends StatefulWidget {
  const SlpashScreen({super.key});

  @override
  State<SlpashScreen> createState() => _SlpashScreenState();
}

class _SlpashScreenState extends State<SlpashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(() => const WelcomScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      cild: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/logo.svg'),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  height: 42.h,
                  width: 168.w,
                  child: ReuseableText(
                      text: 'Connect. Shop. Play. Earn with us',
                      style: appStyle(14, offWhite, FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReuseableText(
                    text: 'All right reserved ',
                    style: appStyle(12, white, FontWeight.w500)),
                SizedBox(
                  height: 4.h,
                ),
                ReuseableText(
                    text: '(c) 2024',
                    style: appStyle(12, white, FontWeight.w500))
              ],
            ),
          ),
        )
      ]),
      color: blue,
    );
  }
}
