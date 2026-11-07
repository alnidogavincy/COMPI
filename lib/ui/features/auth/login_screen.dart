import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../core/app_typography.dart';
import '../../providers/student_provider.dart';
import '../main/main_navigation_screen.dart';

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
  void initState() {
    super.initState();
    _controller.text = context.read<StudentProvider>().identity;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (_controller.text.trim().isEmpty) {
      setState(() => _error = 'Masukkan nama terlebih dahulu.');
      return;
    }
    setState(() {
      _error = null;
      _busy = true;
    });
    try {
      await context.read<StudentProvider>().save(_controller.text);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'Gagal menyimpan identitas. Coba lagi.');
      }
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
              const CompiHeader(
                title: 'Media Pembelajaran Perangkat Keras',
                action: SoundToggle(),
              ),
              const SizedBox(height: 10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 212),
                    child: CompiPanel(
                      padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Selamat Datang!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 32,
                              fontFamily: AppTypography.displayFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            'Masukkan identitas kamu untuk mulai belajar perangkat keras komputer.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textGray,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Identitas Siswa',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _controller,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _start(),
                            decoration: InputDecoration(
                              hintText: 'Nama lengkap',
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
                            alignment: Alignment.center,
                            child: PhysicalButton(
                              child: TextButton(
                                onPressed: () => _controller.text = 'Vika',
                                child: const Text('Contoh identitas: Vika'),
                              ),
                            ),
                          ),
                          CompiButton(
                            label: _busy ? 'Menyimpan...' : 'Mulai Belajar',
                            onPressed: _busy ? null : _start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: SizedBox(
                        height: 240,
                        child: Image.asset(
                          'assets/images/login_welcome_character_compi.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomCenter,
                          cacheWidth: 720,
                          semanticLabel:
                              'Karakter COMPI menyambut dan menunjuk ke formulir identitas',
                        ),
                      ),
                    ),
                  ),
                ],
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
