// ignore_for_file: deprecated_member_use

import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/tap_screen/widgets/diagonal_cut_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SecondCustomDetail extends StatelessWidget {
  const SecondCustomDetail({
    super.key,
    required this.profileImg,
    required this.likes,
    required this.comments,
    required this.bookmark,
    required this.shares,
    required this.isLiked,
    required this.onTap,
  });
  final String profileImg;
  final double likes, comments, bookmark, shares;
  final bool isLiked;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            // color: white,
            shape: BoxShape.circle,
            border: Border.all(width: 1.w, color: white),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(profileImg),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        GestureDetector(
          onTap: onTap,
          child: isLiked
              ? Icon(
                  CupertinoIcons.heart_fill,
                  size: 24.sp,
                  color: appRed,
                )
              : Icon(
                  CupertinoIcons.heart,
                  size: 24.sp,
                  color: white,
                ),
        ),
        SizedBox(
          height: 2.h,
        ),
        ReuseableText(
          text: formatNumber(likes),
          style: appStyle(10, white, FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        SvgPicture.asset(
          'assets/icons/chat.svg',
          color: white,
          height: 24.sp,
          width: 24.sp,
        ),
        SizedBox(
          height: 2.h,
        ),
        ReuseableText(
          text: formatNumber(comments),
          style: appStyle(10, white, FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        Icon(
          CupertinoIcons.bookmark,
          size: 24.sp,
          color: white,
        ),
        SizedBox(
          height: 2.h,
        ),
        ReuseableText(
          text: formatNumber(bookmark),
          style: appStyle(10, white, FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        SvgPicture.asset(
          'assets/icons/forward-outline.svg',
          color: white,
          height: 24.sp,
          width: 24.sp,
        ),
        SizedBox(
          height: 2.h,
        ),
        ReuseableText(
          text: formatNumber(shares),
          style: appStyle(10, white, FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        Stack(
          children: [
            ClipPath(
              clipper: DiagonalCutClipper(),
              child: Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  border: Border.all(color: white, width: 2.w),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://s3-alpha-sig.figma.com/img/7158/46b9/2620b12d1d91cf0dae827465286d4614?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GKQE25nRuRSAFtEoXJeGqFFSwsI23ISo78uGJJZSkPm9aLiss35mgBL33unQq6xGqOwADSVh2EpIJfIfhHoo2YWjECJSZXc-qdwWGSUYlHbEpVXwUf33w7GljxB5vEBU7fYLntKelD3DohVqf~xGBmg6AP4tU~jRbyI4BLf3BvJqXeyCl7v1D5oWWnbPRB0zy10J8QPXgmX8taIdDQCoW4nE7sZxfuIideQ6vTj22pUSFmL7w2g~rDAE8lh8Bq2Vg3lpU22ca2Z5P87oDwFmuRQe68MKFXCrCcXkzzXparsqJ0ncEkVLVv2AhYvZY3tQD~DevFbZiyfzd-N8hRVdAA__',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(height: 15.h, 'assets/icons/music.svg'),
            )
          ],
        )
      ],
    );
  }

  String formatNumber(double number) {
    if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}k";
    } else {
      return number.toStringAsFixed(0);
    }
  }
}
