import 'package:flutter/material.dart';
class CurvedCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const double radius = 20;
    const double buttonWidth = 60;
    var path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - buttonWidth - 5, 0)
      ..quadraticBezierTo(
        size.width - buttonWidth, 0,
        size.width - buttonWidth, 5,
      )
      ..lineTo(size.width - buttonWidth, 60 - 0)
      ..quadraticBezierTo(
        size.width - buttonWidth, 80,
        size.width - buttonWidth + 15, 80,
      )
      ..lineTo(size.width - 5, 80)
      ..quadraticBezierTo(
        size.width, 80,
        size.width, 80 + 10,
      ) 
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
        size.width, size.height,
        size.width - radius, size.height,
      )
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(
        0, size.height,
        0, size.height - radius,
      )
      ..lineTo(0, radius)
      ..quadraticBezierTo(
        0, 0,
        radius, 0,
      )
      ..close();

    canvas.drawShadow(path, Colors.black, 3.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}