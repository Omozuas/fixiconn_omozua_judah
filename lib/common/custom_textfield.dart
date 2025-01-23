import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    super.key,
    required this.firstText,
    required this.hintText,
    this.keyboardType,
    required this.controller,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.onForgotPassword,
    this.autofocus = false,
    this.onChanged,
    this.maxLengthEnforcement,
    this.contentPadding,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.extraText, // Optional callback for "Forgot Password?"
  });
  final String? firstText, hintText, extraText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText, autofocus, readOnly;
  final VoidCallback? onForgotPassword; // Callback for when the link is tapped
  final Function(String)? onChanged;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength, maxLines;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ReuseableText(
                text: firstText ?? '',
                style: appStyle(12, appDgray, FontWeight.w500)),
            ReuseableText(
                text: extraText ?? '',
                style: appStyle(12, appRed, FontWeight.w500)),
          ],
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          validator: validator,
          autofocus: autofocus,
          maxLength: maxLength,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          maxLengthEnforcement: maxLengthEnforcement,
          readOnly: readOnly,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            // hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //       color: GlobalColors.textblackSmallColor,
            //     ),
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: appLgray, width: .3),
            ),
          ),
        ),
      ],
    );
  }
}
