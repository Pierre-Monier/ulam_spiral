import 'package:flutter/material.dart';
import 'package:prime_numbers/prime_numbers.dart';

class UlamSpiral extends CustomPainter {
  static const pointSize = 100;

  @override
  void paint(Canvas canvas, Size size) {
    var number = 1;

    var direction = Direction.right;
    var current = 1;
    var set = 1;
    var cycle = 1;

    var offset = Offset(size.width / 2, size.height / 2);

    for (var y = 0.0; y <= size.height; y += pointSize) {
      for (var x = 0.0; x <= size.width; x += pointSize) {
        paintNumber(canvas, offset, number);
        offset = getNextOffset(offset, direction);

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

        number++;
      }
    }
  }

  void paintNumber(Canvas canvas, Offset offset, int number) {
    final numberPaint = TextPainter(
        text: TextSpan(
          text: (number).toString(),
          style: TextStyle(
            fontSize: 10,
            color: number.isPrime ? Colors.amber : Colors.red,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);

    numberPaint.layout();
    numberPaint.paint(canvas, offset);
  }

  Offset getNextOffset(Offset baseOffset, Direction nextDirection) {
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
  runApp(CustomPaint(
    painter: UlamSpiral(),
  ));
}
