import 'package:fixiconn/common/background_image_container.dart';
import 'package:fixiconn/common/reuseable_button.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
      cild: Stack(
        children: [
          Center(
            child: SvgPicture.asset("assets/images/logo.svg"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReuseableButton(
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                    color: white,
                    textcolor: appBlue,
                    horizontal: 50,
                    vertical: 12,
                    text: 'Log In',
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ReuseableButton(
                    onTap: () {},
                    color: appBlue,
                    textcolor: white,
                    horizontal: 50,
                    vertical: 12,
                    text: 'Sign Up',
                  )
                ],
              ),
            ),
          )
        ],
      ),
      img: "assets/images/backgroungimg.jpg",
    );
  }
}
