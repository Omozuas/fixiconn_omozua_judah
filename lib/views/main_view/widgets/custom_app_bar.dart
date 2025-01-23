// ignore_for_file: deprecated_member_use

import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/main_view/mini_app_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onTap,
    required this.currentTheme,
  });
  final void Function()? onTap;
  final AppTheme currentTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 56.h,
      decoration: BoxDecoration(
          color: currentTheme == AppTheme.light
              ? white.withOpacity(0.5)
              : Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
        ),
        child: SizedBox(
          width: width,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        CupertinoIcons.arrow_left_circle,
                        color:
                            currentTheme == AppTheme.light ? appBlack : white,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReuseableText(
                  text: 'Mini Apps',
                  style: appStyle(
                      16,
                      currentTheme == AppTheme.light ? appBlack : white,
                      FontWeight.w500),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/icons/search2.svg',
                        height: 24.h,
                        color:
                            currentTheme == AppTheme.light ? appBlack : white,
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/icons/ranking.svg',
                        height: 24.h,
                        color:
                            currentTheme == AppTheme.light ? appBlack : white,
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.w,
                                color: currentTheme == AppTheme.light
                                    ? appBlack
                                    : white),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://s3-alpha-sig.figma.com/img/9afa/40e6/7f9adfb6486c67063d80474f4d89a506?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XiWKWGwRsVlz7VBcwwZEsq0mFHgtXD55~1bcuAuH-j8jwI1kK8zTLMan-GudcMaSD~rHG4LbHIJN~sAVvhPNau2dl9hasR643j7PJgO6FEs3iQC8i~Tr7u5k2SnEc0s~bpviuKZZwPOtl~j6fzek4anzGZOmwxY2A1wlIftiXN2vmG1MurA9U2o8aIIxVQ2wqsRo67coRkKnrxleCHXqUJUTLqwrrQJEnhRAlfq7ItcYRdaEad8Y1gpeVEHkIrrukACWKxPGF305Z52wDugVBctD7Xtf370QqkWwm1ZtE46nKOmOqF6bqOMx-U90xsARcwDZmTmMJ37iTIUAv1bA~g__'),
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
