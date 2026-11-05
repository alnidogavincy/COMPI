import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/quiz_provider.dart';
import 'quiz_screen.dart';

class QuizInstructionsScreen extends StatelessWidget {
  const QuizInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CompiHeader(
                  title: 'Petunjuk Latihan',
                  onBack: () => Navigator.pop(context),
                ),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.yellow, width: 3),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: AppColors.yellow,
                        size: 72,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Siap-siap, ada batas waktu!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Baca petunjuk ini sebelum memulai Latihan Pemahaman.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const CompiPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InstructionRow(
                        icon: Icons.hourglass_top,
                        title: '10 detik untuk setiap soal',
                        description:
                            'Timer mulai saat soal ditampilkan. Perhatikan waktu yang tersisa.',
                      ),
                      SizedBox(height: 18),
                      _InstructionRow(
                        icon: Icons.skip_next,
                        title: 'Waktu habis? Otomatis lanjut',
                        description:
                            'Jika belum menjawab dalam 10 detik, jawaban dihitung salah dan soal berikutnya langsung muncul.',
                      ),
                      SizedBox(height: 18),
                      _InstructionRow(
                        icon: Icons.touch_app,
                        title: 'Pilih jawaban sebelum waktu habis',
                        description:
                            'Ketuk satu jawaban. Setelah semua soal selesai, hasil latihanmu akan ditampilkan.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CompiButton(
                  label: 'Saya Mengerti, Mulai Latihan',
                  onPressed: () {
                    context.read<QuizProvider>().loadQuiz(dummyQuizQuestions);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InstructionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InstructionRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primary,
        child: Icon(icon),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(color: AppColors.textGray),
            ),
          ],
        ),
      ),
    ],
  );
}
