import 'package:flutter/material.dart';

class UlamSpiral extends CustomPainter {
  static const pointSize = Size(10, 10);

  @override
  void paint(Canvas canvas, Size size) {
    for (var y = 0.0; y <= size.height; y += pointSize.height) {
      for (var x = 0.0; x <= size.width; x += pointSize.width) {
        canvas.drawRect(
            Rect.fromCenter(center: Offset(x, y), width: 5, height: 5),
            Paint()..color = Colors.amber);
      }
    }
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
