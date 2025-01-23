import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.h,
      width: 39.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [skyBlue, white], // Define your gradient colors here
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      child: Center(
        child: Container(
          height: 35.h,
          width: 35.w,
          decoration: BoxDecoration(
            color: skyBlue, // Inner container's background color
            borderRadius: BorderRadius.circular(8.r), // Match the border curve
          ),
          child: Center(
            child: Icon(
              AntDesign.plus,
              size: 19.sp,
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
