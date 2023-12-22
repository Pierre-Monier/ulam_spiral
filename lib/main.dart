import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prime_numbers/prime_numbers.dart';

class UlamSpiral extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const maxNumber = 10000;

    var direction = Direction.right;
    var current = 1;
    var set = 1;
    var cycle = 1;

    var offset = Offset(size.width / 2, size.height / 2);
    final pointSize = sqrt((size.width * size.height) / maxNumber);

    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFE0FFFF), Color(0xFFB0E0E6)],
      stops: [0.0, 1.0],
    );
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(Rect.largest, paint);

    for (var number = 1; number < maxNumber; number++) {
      _paintNumber(canvas, offset, number, pointSize);
      offset = getNextOffset(offset, direction, pointSize);

      if (current < cycle) {
        current++;
      } else if (set < 2) {
        set++;
        current = 1;
        direction = direction.getNextDirection();
      } else {
        set = 1;
        current = 1;
        cycle++;
        direction = direction.getNextDirection();
      }
    }
  }

  void _paintNumber(
      Canvas canvas, Offset offset, int number, double pointSize) {
    var factors = number.factors().length.toDouble();
    factors--;

    Color color;
    if (_isPerfectSquare(factors.toInt())) {
      color = Colors.purple;
    } else {
      int shade = (255 / pointSize * factors).toInt();
      color = Color.fromARGB(255, 0, 0, shade);
    }

    if (factors > 0) {
      factors = pow(factors, (0.75)).toDouble();
      canvas.drawCircle(
        offset,
        factors.toDouble(),
        Paint()..color = color,
      );
    }
  }

  bool _isPerfectSquare(int number) {
    double sqrtValue = sqrt(number);

    if (sqrtValue.isInfinite || sqrtValue.isNaN) {
      return false;
    }

    return sqrtValue * sqrtValue == number;
  }

  Offset getNextOffset(
      Offset baseOffset, Direction nextDirection, double pointSize) {
    switch (nextDirection) {
      case Direction.left:
        return Offset(baseOffset.dx - pointSize, baseOffset.dy);
      case Direction.up:
        return Offset(baseOffset.dx, baseOffset.dy - pointSize);
      case Direction.right:
        return Offset(baseOffset.dx + pointSize, baseOffset.dy);
      case Direction.bottom:
        return Offset(baseOffset.dx, baseOffset.dy + pointSize);
    }
  }

  @override
  bool shouldRepaint(covariant UlamSpiral oldDelegate) {
    return false;
  }
}

enum Direction {
  right(),
  up(),
  left(),
  bottom();

  const Direction();

  Direction getNextDirection() {
    switch (this) {
      case Direction.right:
        return Direction.up;
      case Direction.up:
        return Direction.left;
      case Direction.left:
        return Direction.bottom;
      case Direction.bottom:
        return Direction.right;
    }
  }
}

void main() {
  runApp(
    Center(
      child: SizedBox(
        width: 700,
        height: 700,
        child: CustomPaint(
          painter: UlamSpiral(),
        ),
      ),
    ),
  );
}
