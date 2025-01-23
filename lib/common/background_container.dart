import 'package:fixiconn/constants/constants.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer(
      {super.key, required this.cild, required this.color});
  final Widget cild;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
      ),
      child: cild,
    );
  }
}
