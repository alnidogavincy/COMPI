import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import 'match_up_screen.dart';

class MatchUpInstructionsScreen extends StatelessWidget {
  const MatchUpInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CircuitBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CompiHeader(
                title: 'Petunjuk Match Up',
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
                    Icon(Icons.extension, color: AppColors.yellow, size: 72),
                    SizedBox(height: 10),
                    Text(
                      'Cocokkan gambar perangkat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Baca petunjuk ini sebelum memulai Match the Component.',
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
                      icon: Icons.touch_app,
                      title: 'Seret gambar ke nama komponen',
                      description:
                          'Pindahkan setiap gambar dari kolom kiri ke nama perangkat yang sesuai di kolom kanan.',
                    ),
                    SizedBox(height: 18),
                    _InstructionRow(
                      icon: Icons.shuffle,
                      title: 'Urutan dibuat acak',
                      description:
                          'Gambar dan nama komponen disusun secara acak. Perhatikan setiap pasangan sebelum menjawab.',
                    ),
                    SizedBox(height: 18),
                    _InstructionRow(
                      icon: Icons.swap_horiz,
                      title: 'Pasangan masih bisa dipindahkan',
                      description:
                          'Jika ingin mengganti jawaban, seret kembali gambar yang sudah ditempatkan ke nama lain.',
                    ),
                    SizedBox(height: 18),
                    _InstructionRow(
                      icon: Icons.send,
                      title: 'Kirim setelah semua terisi',
                      description:
                          'Jawaban belum dinilai saat gambar ditempatkan. Tekan Kirim Jawaban untuk melihat hasil benar dan salah.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CompiButton(
                label: 'Saya Mengerti, Mulai Match Up',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MatchUpScreen()),
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
