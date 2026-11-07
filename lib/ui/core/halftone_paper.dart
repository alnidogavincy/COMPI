import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Static, subtle print texture; paints behind the panel content.
class HalftonePaperPainter extends CustomPainter {
  const HalftonePaperPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final dots = Paint();
    for (double y = 3; y < size.height; y += 7) {
      for (double x = 3; x < size.width; x += 7) {
        final fade = (.45 + .55 * (x / size.width));
        dots.color = Colors.black.withValues(alpha: .25 * fade);
        canvas.drawCircle(Offset(x, y), .85, dots);
      }
    }
    final random = math.Random(41);
    final fibers = Paint()..strokeWidth = .55;
    for (var i = 0; i < size.width * size.height / 70; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      fibers.color = (i.isEven ? Colors.white : Colors.black).withValues(
        alpha: .07,
      );
      canvas.drawLine(
        Offset(x, y),
        Offset(x + 1 + random.nextDouble() * 3, y + .5),
        fibers,
      );
    }
  }

  @override
  bool shouldRepaint(covariant HalftonePaperPainter oldDelegate) => false;
}
