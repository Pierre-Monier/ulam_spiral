import 'package:flutter/material.dart';

class UlamSpiral extends CustomPainter {
  static const pointSize = Size(100, 100);

  @override
  void paint(Canvas canvas, Size size) {
    var n = 0;

    for (var y = 0.0; y <= size.height; y += pointSize.height) {
      for (var x = 0.0; x <= size.width; x += pointSize.width) {
        final numberPaint = TextPainter(
            text: TextSpan(
                text: n.toString(),
                style: const TextStyle(fontSize: 8, color: Colors.amber)),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center);

        numberPaint.layout();
        numberPaint.paint(canvas, Offset(x, y));

        n++;
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
