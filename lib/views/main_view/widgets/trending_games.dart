import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/main_view/mini_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingGames extends StatelessWidget {
  const TrendingGames({
    super.key,
    required this.item,
    required this.onTap,
    required this.currentTheme,
  });

  final dynamic item;
  final void Function() onTap;
  final AppTheme currentTheme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: appBlack,
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(item["img"]),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            ReuseableText(
              text: item["gameName"],
              style: appStyle(
                  10,
                  currentTheme == AppTheme.light ? appBlack : white,
                  FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
