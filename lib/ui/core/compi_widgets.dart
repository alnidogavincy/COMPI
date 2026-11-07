import '../../data/avatar_catalog.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'physical_button.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
export 'physical_button.dart';

const double _compiLogoWidth = 150;
const double _compiLogoHeight = 48;

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({super.key, this.radius = 16});
  final double radius;
  @override
  Widget build(BuildContext context) {
    final avatar = findAvatar(context.watch<StudentProvider?>()?.avatarId);
    final fallback = Icon(
      Icons.person_outline,
      color: Colors.white,
      size: radius * 1.3,
    );
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary,
      child:
          avatar == null
              ? fallback
              : ClipOval(
                child: Image.asset(
                  avatar.asset,
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => fallback,
                ),
              ),
    );
  }
}

class CircuitBackground extends StatelessWidget {
  final Widget child;
  const CircuitBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints.expand(),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF60DFFF), Color(0xFF079DEE), Color(0xFF0754CB)],
      ),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(child: CustomPaint(painter: _CircuitPainter())),
        ),
        child,
      ],
    ),
  );
}

class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid =
        Paint()
          ..color = Colors.white.withValues(alpha: .12)
          ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 36) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 36) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final circuit =
        Paint()
          ..color = const Color(0xFF80E8FF).withValues(alpha: .5)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;
    for (double y = 68; y < size.height; y += 170) {
      final path =
          Path()
            ..moveTo(0, y)
            ..lineTo(26, y)
            ..lineTo(60, y + 32)
            ..lineTo(128, y + 32);
      canvas.drawPath(path, circuit);
      canvas.drawCircle(Offset(128, y + 32), 5, circuit);
      final right =
          Path()
            ..moveTo(size.width, y + 76)
            ..lineTo(size.width - 28, y + 76)
            ..lineTo(size.width - 58, y + 106)
            ..lineTo(size.width - 98, y + 106);
      canvas.drawPath(right, circuit);
      canvas.drawCircle(Offset(size.width - 98, y + 106), 5, circuit);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Shared branding for the three main tabs. The parent supplies page gutters.
class CompiBrandHeader extends StatelessWidget {
  const CompiBrandHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _CompiHorizontalLogo(),
              ),
            ),
            if (action != null) ...[const SizedBox(width: 12), action!],
          ],
        ),
      ],
    ),
  );
}

class _CompiHorizontalLogo extends StatelessWidget {
  const _CompiHorizontalLogo();

  @override
  Widget build(BuildContext context) => SizedBox(
    key: const ValueKey('compi-header-logo'),
    width: _compiLogoWidth,
    height: _compiLogoHeight,
    child: FittedBox(
      fit: BoxFit.contain,
      child: ClipRect(
        child: Align(
          widthFactor: 1417 / 2048,
          heightFactor: 426 / 2048,
          alignment: const Alignment(243 / 631, 252 / 1622),
          child: Image.asset(
            'assets/images/compi_header_v2.png',
            width: 260,
            height: 260,
            fit: BoxFit.contain,
            semanticLabel: 'COMPI — Computer Interactive 3D',
          ),
        ),
      ),
    ),
  );
}

class CompiHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? action;
  final Widget? leading;
  const CompiHeader({
    super.key,
    required this.title,
    this.onBack,
    this.action,
    this.leading,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    child: Row(
      children: [
        if (onBack != null)
          PhysicalButton(
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        if (onBack != null) ...[
          const SizedBox(width: 12),
          const Expanded(child: Center(child: CompiWordmark())),
          if (action != null) action! else const SizedBox(width: 48),
        ] else ...[
          const _CompiHorizontalLogo(),
          const Spacer(),
          if (action != null) action! else if (leading != null) leading!,
        ],
      ],
    ),
  );
}

class CompiPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const CompiPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: AppColors.border, width: 3),
      boxShadow: const [
        BoxShadow(
          color: AppColors.primaryDark,
          blurRadius: 0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Material(type: MaterialType.transparency, child: child),
  );
}

class SectionBanner extends StatelessWidget {
  final IconData icon;
  final String title;
  const SectionBanner({super.key, required this.icon, required this.title});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
    decoration: const BoxDecoration(
      color: AppColors.orange,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: AppTypography.displayFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

class CompiButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool secondary;
  const CompiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.secondary = false,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: PhysicalButton(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              secondary ? AppColors.primaryLight : AppColors.orange,
          foregroundColor: secondary ? AppColors.primaryDark : Colors.white,
          side: BorderSide(
            color: secondary ? AppColors.cyan : AppColors.yellow,
            width: 2,
          ),
        ),
        child: Text(label),
      ),
    ),
  );
}

/// Clip only transparent margins; retain the supplied PNG unchanged.
class CompiWordmark extends StatelessWidget {
  const CompiWordmark({super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 138,
    height: 58,
    child: FittedBox(
      child: ClipRect(
        child: Align(
          widthFactor: 1640 / 2048,
          heightFactor: 704 / 2048,
          alignment: const Alignment(32 / 408, 112 / 1344),
          child: Image.asset(
            'assets/images/profile_wordmark.png',
            width: 256,
            height: 256,
          ),
        ),
      ),
    ),
  );
}
