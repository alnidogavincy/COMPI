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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Simulasi Gambar 3D Rig PC
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.computer,
                    size: 100,
                    color: Colors.blue[600],
                  ), // Placeholder untuk 3D Rig Image
                ),
              ),
              const SizedBox(height: 40),
              
              // Teks Judul
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'COMPI',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[700],
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Aplikasi Media Pembelajaran Perangkat Keras\nKomputer Berbasis Visualisasi 3D',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              
              // Chips Fitur
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _FeatureChip(icon: Icons.view_in_ar, label: '3D Interaktif'),
                  _FeatureChip(icon: Icons.psychology, label: 'Kuis Menantang'),
                  _FeatureChip(icon: Icons.school, label: 'Kurikulum SMK TKJ'),
                ],
              ),
              const Spacer(),
              
              // Tombol Mulai
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2954E3),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mulai Belajar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
