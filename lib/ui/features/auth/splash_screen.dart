import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _reveal;
  late final Animation<double> _scale;
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _reveal = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, .65, curve: Curves.easeOut),
    );
    _scale = Tween(begin: .65, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, .85, curve: Curves.easeOutBack),
      ),
    );
    _controller.forward();
    _timer = Timer(const Duration(milliseconds: 3200), _continue);
  }

  void _continue() {
    if (!mounted || _navigated) return;
    _navigated = true;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 550),
        pageBuilder: (_, animation, secondaryAnimation) => const LoginScreen(),
        transitionsBuilder:
            (_, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CircuitBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder:
              (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: FadeTransition(
                          opacity: _reveal,
                          child: CompiPanel(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ScaleTransition(
                                  scale: _scale,
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    builder:
                                        (context, child) => Transform.rotate(
                                          angle: -.15 * (1 - _reveal.value),
                                          child: child,
                                        ),
                                    child: Image.asset(
                                      'assets/images/splash_cube.png',
                                      height: 210,
                                      semanticLabel: 'Logo COMPI 3D',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'COMPI',
                                        style: TextStyle(
                                          fontSize: 46,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '3D',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Media Pembelajaran Perangkat Keras',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Kenali • Eksplorasi • Pelajari',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.textGray),
                                ),
                                const SizedBox(height: 26),
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder:
                                      (context, _) => LinearProgressIndicator(
                                        value: _controller.value,
                                        minHeight: 6,
                                        color: AppColors.orange,
                                        backgroundColor: AppColors.primaryLight,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    ),
  );
}