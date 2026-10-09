import 'package:flutter/material.dart';
import 'app_colors.dart';

class CircuitBackground extends StatelessWidget {
  final Widget child;
  const CircuitBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
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

class CompiHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? action;
  const CompiHeader({super.key, required this.title, this.onBack, this.action});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    child: Row(
      children: [
        if (onBack != null)
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.orange,
              foregroundColor: Colors.white,
            ),
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
          )
        else
          Image.asset('assets/images/app_logo.png', width: 42, height: 42),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'COMPI 3D',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: AppColors.primaryDark,
                      blurRadius: 3,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (action != null) action!,
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
      gradient: LinearGradient(
        colors: [AppColors.yellow, AppColors.orange, AppColors.primary],
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(12),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.primaryDark),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}

class CompiButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool secondary;
  const CompiButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.secondary = false,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary ? AppColors.primaryLight : AppColors.orange,
        foregroundColor: secondary ? AppColors.primaryDark : Colors.white,
        side: BorderSide(
          color: secondary ? AppColors.cyan : AppColors.yellow,
          width: 2,
        ),
      ),
    ),
  );
}
