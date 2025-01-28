import 'dart:developer';

import 'package:fixiconn/apis/river_pod/auth/auth_provider.dart';
import 'package:fixiconn/common/custom_textfield.dart';
import 'package:fixiconn/common/larg_button.dart';
import 'package:fixiconn/common/snackbar/custom_snack_bar.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  bool _isPasswordObscured = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  // Validate and Sign Up
  void proceed() async {
    log(".....start");
    final String username = _userNameController.text;
    final String password = _passwordController.text;

    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref
            .read(setupProfileProvider.notifier)
            .signUp(userName: username, password: password);
        final res = ref.read(setupProfileProvider).signup.value;
        if (res == null) return;
        if (res.success == true) {
          showSuccess(
            res.message ?? '',
          );
          // Proceed with the login process
          Get.to(() => const LoginScreen());
        } else {
          log(res.message ?? '');
          showError(
            res.message ?? '',
          );
        }
      } catch (e) {
        log(e.toString());
        showError(
          e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(setupProfileProvider).signup.isLoading;
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, bottom: 10.h, top: 40.h),
              child: Column(
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
                          isLoading: isLoading,
                          textcolor: white,
                          borderColor: appBlue,
                          text: 'Sign up',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: LargButton(
                        onTap: () {
                          Get.to(() => const LoginScreen());
                        },
                        borderColor: appLgray,
                        color: white,
                        textcolor: appBlue,
                        text: 'already have an account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
