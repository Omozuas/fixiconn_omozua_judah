// ignore_for_file: deprecated_member_use

import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FirstCustomDetail extends StatelessWidget {
  const FirstCustomDetail({
    super.key,
    required this.username,
    required this.about,
  });
  final String username, about;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26.h,
            width: 110.w,
            decoration:
                BoxDecoration(color: appBlack, shape: BoxShape.rectangle),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w, bottom: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/icons/shop.svg',
                    color: white,
                    height: 20.h,
                  ),
                  ReuseableText(
                    text: 'Shop .4',
                    style: appStyle(12, white, FontWeight.w500),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 17.sp,
                    color: white,
                  )
                ],
              ),
            ),
          ),
          ReuseableText(
            text: username,
            style: appStyle(14, white, FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  about,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: appStyle(12, white, FontWeight.w500),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'see more',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: appStyle(10, white, FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: appBlack.withOpacity(0.39),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/music.svg",
                        height: 18.h,
                      ),
                      Expanded(
                        child: ReuseableText(
                            text: 'Falz .How Many (feat. Crayon)',
                            style: appStyle(10, white, FontWeight.w500)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Container(
                height: 24.h,
                decoration: BoxDecoration(
                  color: appBlack.withOpacity(0.39),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/magicpen.svg",
                        height: 18.h,
                      ),
                      ReuseableText(
                        text: 'Effect Name',
                        style: appStyle(10, white, FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
