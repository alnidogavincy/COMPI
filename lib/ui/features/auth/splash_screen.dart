import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import 'splash_loading_bar.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _reveal;
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
    _reveal = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, .18, curve: Curves.easeOut),
    );
    _controller.forward();
    _timer = Timer(const Duration(milliseconds: 3500), _continue);
  }

  void _continue() {
    if (!mounted || _navigated) return;
    _navigated = true;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
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
    _reveal.dispose();
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
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 20, 12, 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/splash_mist.png',
                                ),
                                fit: BoxFit.cover,
                                opacity: .65,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.border.withValues(alpha: .65),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryDark.withValues(
                                    alpha: .12,
                                  ),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _BlendWithPanel(
                                  child: Image.asset(
                                    'assets/images/splash_brand.png',
                                    fit: BoxFit.contain,
                                    semanticLabel:
                                        'COMPI — Computer Interactive 3D',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: SplashLoadingBar(
                                    animation: _controller,
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

// The supplied artwork has an opaque white background. Multiply lets the
// panel's mist show through white pixels without modifying the source PNG.
class _BlendWithPanel extends SingleChildRenderObjectWidget {
  const _BlendWithPanel({required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _PanelBlendRender();
}

class _PanelBlendRender extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()..blendMode = BlendMode.multiply,
    );
    super.paint(context, offset);
    context.canvas.restore();
  }
}
