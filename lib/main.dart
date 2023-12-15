import 'package:flutter/material.dart';

class UlamSpiral extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height),
        Paint()..color = Colors.amber);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void main() {
  runApp(CustomPaint(
    painter: UlamSpiral(),
  ));
}
