import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/main_view/mini_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesOFGames extends StatelessWidget {
  const CategoriesOFGames({
    super.key,
    required this.onTap,
    required this.currentTheme,
    required this.url,
    required this.name,
  });

  final String url, name;
  final void Function() onTap;
  final AppTheme currentTheme;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 64.h,
            width: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: appBlack,
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: url == "No Internet connection"
                    ? const AssetImage('assets/images/bk2.jpg')
                    : NetworkImage(url),
              ),
            ),
          ),
          SizedBox(
            width: 5.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReuseableText(
                text: name,
                style: appStyle(
                    10,
                    currentTheme == AppTheme.light ? appBlack : white,
                    FontWeight.w700),
              ),
              ReuseableText(
                text: 'Hello game',
                style: appStyle(
                    10,
                    currentTheme == AppTheme.light ? appBlack : white,
                    FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }
}
