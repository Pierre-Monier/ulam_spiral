import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prime_numbers/prime_numbers.dart';

class UlamSpiral extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var direction = Direction.right;
    var current = 1;
    var set = 1;
    var cycle = 1;

    var offset = Offset(size.width / 2, size.height / 2);
    const maxNumber = 10000;
    final pointSize = sqrt((size.width * size.height) / maxNumber);

    canvas.drawRect(Rect.largest, Paint()..color = Colors.black);

    for (var number = 1; number < maxNumber; number++) {
      paintNumber(canvas, offset, number, pointSize);
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

  void paintNumber(Canvas canvas, Offset offset, int number, double pointSize) {
    var factors = number.factors().length.toDouble();
    factors--;

    if (factors > 0) {
      factors = pow(factors, (0.75)).toDouble();

      canvas.drawCircle(
        offset,
        min(factors, pointSize).toDouble(),
        Paint()..color = Colors.blue,
      );
    }
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
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
        width: 600,
        height: 600,
        child: CustomPaint(
          painter: UlamSpiral(),
        ),
      ),
    ),
  );
}
