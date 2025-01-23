import 'package:flutter/material.dart';

class ReuseableText extends StatelessWidget {
  const ReuseableText({super.key, required this.text, required this.style});
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
