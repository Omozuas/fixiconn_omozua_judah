import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer(
      {super.key, required this.cild, required this.img});
  final Widget cild;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          image: DecorationImage(
              image: AssetImage(img), fit: BoxFit.cover, opacity: 0.7)),
      child: cild,
    );
  }
}
