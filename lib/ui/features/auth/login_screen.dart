import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/student_provider.dart';
import '../main/main_navigation_screen.dart';
import 'splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  String? _error;
  bool _busy = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (_controller.text.trim().isEmpty) {
      setState(() => _error = 'Masukkan nama atau NISN terlebih dahulu.');
      return;
    }
    setState(() {
      _error = null;
      _busy = true;
    });
    try {
      await context.read<StudentProvider>().save(_controller.text);
      if (mounted)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
    } catch (_) {
      if (mounted)
        setState(() => _error = 'Gagal menyimpan identitas. Coba lagi.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CircuitBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CompiHeader(
                title: 'Media Pembelajaran Perangkat Keras',
                onBack:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                    ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/hardware_banner.png',
                      height: 230,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      bottom: 12,
                      left: 12,
                      child: Chip(label: Text('Simulasi Interaktif 3D')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CompiPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Siswa SMK • Teknik Komputer & Jaringan',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      'Masukkan identitas kamu untuk mulai belajar perangkat keras komputer.',
                      style: TextStyle(color: AppColors.textGray, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Identitas Siswa',
                      style: TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _start(),
                      decoration: InputDecoration(
                        hintText: 'Nama lengkap atau NISN',
                        prefixIcon: const Icon(Icons.badge_outlined),
                        errorText: _error,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _controller.text = 'Vika (TKJ)',
                        child: const Text('Coba identitas demo: Vika (TKJ)'),
                      ),
                    ),
                    CompiButton(
                      label: _busy ? 'Menyimpan...' : 'Mulai Belajar',
                      icon: Icons.arrow_forward,
                      onPressed: _busy ? null : _start,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Identitas disimpan di perangkat ini. Tidak memerlukan akun online.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
