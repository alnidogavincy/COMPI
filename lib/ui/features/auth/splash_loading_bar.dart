import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Compact adaptation of the supplied aurora-wave progress reference.
/// Progress describes the splash presentation, not asset/network loading.
class SplashLoadingBar extends StatelessWidget {
  const SplashLoadingBar({super.key, required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Membuka Compi',
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 16,
        width: double.infinity,
        child: CustomPaint(painter: _AuroraPainter(animation)),
      ),
    ),
  );
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter(this.animation) : super(repaint: animation);
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas.drawRect(bounds, Paint()..color = const Color(0xFFFFEBD8));
    final progress = animation.value.clamp(0.0, 1.0);
    if (progress <= 0) return;
    final phase = progress * math.pi * 6;
    final amplitude = size.height * .22 * math.sin(progress * math.pi);
    final edge = size.width * progress;
    double wave(double y, double shift) {
      final t = y / size.height;
      return edge +
          shift +
          amplitude *
              (math.sin(t * math.pi * 1.6 + phase) * .65 +
                  math.cos(t * math.pi * 2.8 - phase * .7) * .35);
    }

    Path crest(double shift) {
      final path = Path()..moveTo(wave(0, shift), 0);
      for (var i = 1; i <= 32; i++) {
        final y = size.height * i / 32;
        path.lineTo(wave(y, shift), y);
      }
      return path;
    }

    final fill =
        Path()
          ..moveTo(0, 0)
          ..lineTo(wave(0, 0), 0);
    for (var i = 1; i <= 32; i++) {
      final y = size.height * i / 32;
      fill.lineTo(wave(y, 0), y);
    }
    fill
      ..lineTo(0, size.height)
      ..close();
    canvas.save();
    canvas.clipPath(fill);
    canvas.drawRect(
      bounds,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(math.max(edge, 1), 0),
          [const Color(0xFFE9500B), AppColors.orange, AppColors.yellow],
          [0, .7, 1],
        ),
    );
    for (var i = 0; i < 3; i++) {
      canvas.drawPath(
        crest(-5.0 - i * 7),
        Paint()
          ..color = AppColors.yellow.withValues(alpha: .38 - i * .08)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    }
    canvas.restore();
    if (progress < 1) {
      canvas.drawPath(
        crest(0),
        Paint()
          ..color = const Color(0xFFFFE7A5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
