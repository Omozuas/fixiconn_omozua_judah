import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/custom_textfield.dart';
import 'package:fixiconn/common/larg_button.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  bool _isPasswordObscured = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  void proceed() {
    if (_formKey.currentState?.validate() ?? false) {
      // Proceed with the login process
      Get.offAll(() => MainScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_circle_left_outlined,
              color: appGray,
              size: 30.sp,
            )),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, bottom: 10.h, top: 40.h),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 50.h,
                      ),
                      child: SvgPicture.asset(
                        "assets/images/logo.svg",
                        // ignore: deprecated_member_use
                        color: appIconBlue,
                      ),
                    ),
                    CustomTextFields(
                        firstText: 'username',
                        extraText: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Username';
                          }

                          return null;
                        },
                        hintText: 'username',
                        controller: _userNameController),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFields(
                        firstText: 'Password',
                        extraText: '*',
                        hintText: '••••••••',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          // Regular expressions for validation
                          final hasUppercase = RegExp(r'[A-Z]');
                          final hasLowercase = RegExp(r'[a-z]');
                          final hasDigits = RegExp(r'[0-9]');
                          final hasSpecialCharacters =
                              RegExp(r'[!@#$%^&*(),.?":{}|<>]');

                          if (!hasUppercase.hasMatch(value)) {
                            return 'Password must include at least one uppercase letter';
                          }
                          if (!hasLowercase.hasMatch(value)) {
                            return 'Password must include at least one lowercase letter';
                          }
                          if (!hasDigits.hasMatch(value)) {
                            return 'Password must include at least one number';
                          }
                          if (!hasSpecialCharacters.hasMatch(value)) {
                            return 'Password must include at least one special character';
                          }
                          return null; // Password is valid
                        },
                        obscureText: _isPasswordObscured,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        controller: _passwordController),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      child: LargButton(
                        onTap: proceed,
                        color: appBlue,
                        textcolor: white,
                        borderColor: appBlue,
                        text: 'Log In',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ReuseableText(
                          text: 'Forgotten Password?',
                          style: appStyle(12, appBlue, FontWeight.w600)),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: LargButton(
                        onTap: () {},
                        borderColor: appLgray,
                        color: white,
                        textcolor: appBlue,
                        text: 'Create new account'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
