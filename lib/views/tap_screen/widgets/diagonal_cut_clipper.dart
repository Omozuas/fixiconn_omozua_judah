import 'package:flutter/cupertino.dart';

class DiagonalCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0); // Top-left corner
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height * 0.4); // Move 70% up from bottom-right
    path.lineTo(
        size.width * 0.4, size.height); // Diagonal to bottom-left corner
    path.lineTo(0, size.height); // Bottom-left corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true; // No need to reclip unless the size changes
  }
}
