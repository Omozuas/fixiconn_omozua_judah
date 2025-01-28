import 'package:fixiconn/app.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void showSuccess(String message,
    {Color backgroundColor = Colors.black, int durationSeconds = 3}) {
  final overlay = navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.h, // Adjust the position as needed
      left: 20.w,
      right: 20.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          // height: 56.h,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: lightGreen.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1, color: showSucces),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline_rounded,
                  color: showSucces, size: 24.w),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Text(
                  message,
                  softWrap: true,
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry
  overlay.insert(overlayEntry);

  // Remove the overlay entry after the specified duration
  Future.delayed(Duration(seconds: durationSeconds), () {
    overlayEntry.remove();
  });
}

void showError(String message, {int durationSeconds = 3}) {
  final overlay = navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.h, // Adjust the position as needed
      left: 20.w,
      right: 20.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          // height: 56.h,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: showLightRed.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1, color: showErro),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cancel_outlined, color: showErro, size: 24.w),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Text(
                  message,
                  softWrap: true,
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry
  overlay.insert(overlayEntry);

  // Remove the overlay entry after the specified duration
  Future.delayed(Duration(seconds: durationSeconds), () {
    overlayEntry.remove();
  });
}
