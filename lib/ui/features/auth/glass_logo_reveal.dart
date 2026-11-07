import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Native Flutter interpretation of the supplied liquid-glass reveal:
/// droplet growth, rounded tile, magnified logo, light sweep, glass release.
/// Paints only within the logo bounds and stops when the reveal finishes.
class GlassLogoReveal extends StatelessWidget {
  const GlassLogoReveal({
    super.key,
    required this.animation,
    required this.child,
  });
  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, logo) {
        final t = animation.value;
        if (reducedMotion || t >= 1) return logo!;
        final grow = Curves.easeOutCubic.transform((t / .32).clamp(0, 1));
        final morph = Curves.easeInOut.transform(((t - .12) / .3).clamp(0, 1));
        final release = Curves.easeInOut.transform(
          ((t - .72) / .28).clamp(0, 1),
        );
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return SizedBox(
              width: width,
              height: width,
              child: Center(
                child: Opacity(
                  opacity: (t / .08).clamp(0, 1),
                  child: SizedBox(
                    width: width * (.16 + .84 * grow),
                    height: width * (.16 + .84 * grow),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        width * (.5 - .42 * morph) * (1 - release),
                      ),
                      child: CustomPaint(
                        foregroundPainter: _GlassPainter(t, release),
                        child: Transform.scale(
                          scale:
                              1 + .7 * (1 - Curves.easeInOutCubic.transform(t)),
                          child: ImageFiltered(
                            imageFilter: ui.ImageFilter.blur(
                              sigmaX: 3 * (1 - grow),
                              sigmaY: 3 * (1 - grow),
                            ),
                            child: logo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _GlassPainter extends CustomPainter {
  const _GlassPainter(this.progress, this.release);
  final double progress, release;
  @override
  void paint(Canvas canvas, Size size) {
    final alpha = 1 - release;
    final bounds = Offset.zero & size;
    final rim = RRect.fromRectAndRadius(
      bounds.deflate(1.5),
      Radius.circular(size.width * .1),
    );
    canvas.drawRRect(
      rim,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: .2 * alpha),
            AppColors.cyan.withValues(alpha: .05 * alpha),
            AppColors.primary.withValues(alpha: .1 * alpha),
          ],
        ).createShader(bounds),
    );
    canvas.drawRRect(
      rim,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: .9 * alpha),
            AppColors.cyan.withValues(alpha: .45 * alpha),
            AppColors.primary.withValues(alpha: .15 * alpha),
          ],
        ).createShader(bounds),
    );
    final sweep = ((progress - .18) / .55).clamp(0.0, 1.0);
    final band = Rect.fromLTWH(
      size.width * (-.6 + 2.2 * sweep),
      0,
      size.width * .5,
      size.height,
    );
    canvas.drawRect(
      bounds,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: .42 * alpha),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(band),
    );
  }

  @override
  bool shouldRepaint(covariant _GlassPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.release != release;
}
