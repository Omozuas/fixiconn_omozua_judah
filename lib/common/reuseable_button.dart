import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReuseableButton extends StatelessWidget {
  const ReuseableButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.textcolor,
    required this.horizontal,
    required this.vertical,
    required this.text,
  });
  final void Function() onTap;
  final Color color, textcolor;
  final double horizontal, vertical;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal.w, vertical: vertical.h),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: ReuseableText(
            text: text, style: appStyle(16, textcolor, FontWeight.w500)),
      ),
    );
  }
}
