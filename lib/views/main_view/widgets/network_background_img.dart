import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/views/main_view/mini_app_screen.dart';
import 'package:flutter/cupertino.dart';

class NetworkBackgroundImg extends StatelessWidget {
  const NetworkBackgroundImg({
    super.key,
    required this.currentTheme,
  });
  final AppTheme currentTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.6,
      decoration: BoxDecoration(
        color: blue,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(currentTheme == AppTheme.light
              ? "assets/images/bk3.jpg"
              : 'assets/images/bk2.jpg'),
        ),
      ),
    );
  }
}
