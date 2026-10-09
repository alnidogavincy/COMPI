import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';

class GameResultScreen extends StatefulWidget {
  const GameResultScreen({super.key});

  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.read<QuizProvider>();
    final score = quizProvider.score * 10;
    
    final totalSoal = quizProvider.questions.isEmpty ? 10 : quizProvider.questions.length;
    final accuracy = "${quizProvider.score}/$totalSoal";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textDark), onPressed: () => Navigator.pop(context)),
        title: Text('Game Result', style: AppTypography.heading3.copyWith(fontSize: 18)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 14, backgroundColor: Colors.black12, child: Icon(Icons.person, size: 16, color: Colors.white)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Container Utama
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
              ),
              child: Column(
                children: [
                  // Image Piala
                  Container(
                    height: 140, width: 140,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.emoji_events, size: 80, color: Colors.amber[400]),
                        const Positioned(
                          top: -5, right: -5,
                          child: CircleAvatar(radius: 12, backgroundColor: Colors.lightBlue, child: Icon(Icons.star, size: 14, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Label & Judul
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified, size: 14, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Text('SIMULASI PERAKITAN SELESAI', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Tantangan Selesai!', style: AppTypography.heading2.copyWith(fontSize: 24)),
                  const SizedBox(height: 8),
                  Text('Luar biasa! Pemahaman perangkat keras komputer kamu sangat mantap.', textAlign: TextAlign.center, style: AppTypography.body.copyWith(height: 1.4)),
                  const SizedBox(height: 32),
                  
                  // Statistik Row
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(label: 'Skor Akhir', value: '$score', suffix: '/100', icon: null),
                        Container(width: 1, height: 40, color: AppColors.border),
                        const _StatItem(label: 'Waktu', value: '02:15', suffix: '', icon: Icons.timer_outlined),
                        Container(width: 1, height: 40, color: AppColors.border),
                        _StatItem(label: 'Akurasi', value: accuracy, suffix: '', icon: Icons.check_circle_outline, iconColor: Colors.teal),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Pencapaian Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.lightBlue[50], borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.military_tech, color: AppColors.primary, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('PENCAPAIAN BARU ', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                                  const Text('🥇', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('Hardware Master TKJ', style: AppTypography.caption.copyWith(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.textDark)),
                              const SizedBox(height: 4),
                              Text('Berhasil mendiagnosis socket CPU, RAM dual-channel, & kartu PCI...', style: AppTypography.caption.copyWith(fontSize: 11, color: Colors.blue[900], height: 1.4)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Tips Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline, size: 20, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTypography.caption.copyWith(fontSize: 11, height: 1.4),
                              children: [
                                const TextSpan(text: 'Sedikit lagi sempurna! Ulangi modul '),
                                TextSpan(text: 'Front Panel I/O', style: AppTypography.caption.copyWith(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                                const TextSpan(text: ' untuk skor 100%.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
                label: Text('Main Lagi', style: AppTypography.subtitle.copyWith(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.home_outlined, color: AppColors.primary, size: 20),
                label: Text('Kembali ke Menu Utama', style: AppTypography.subtitle.copyWith(fontSize: 16, color: AppColors.primary)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String suffix;
  final IconData? icon;
  final Color? iconColor;

  const _StatItem({required this.label, required this.value, required this.suffix, this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (icon != null) Icon(icon, size: 14, color: iconColor ?? AppColors.textDark),
            if (icon != null) const SizedBox(width: 4),
            Text(value, style: AppTypography.heading3.copyWith(fontSize: 20, color: iconColor ?? AppColors.primary)),
            if (suffix.isNotEmpty) Text(suffix, style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
