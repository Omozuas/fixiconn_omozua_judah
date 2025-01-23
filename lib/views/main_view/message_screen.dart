import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left_circle,
            color: appBlack,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: const Center(
        child: Text('message screen'),
      ),
    );
  }
}
