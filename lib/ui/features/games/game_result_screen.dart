import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/quiz_provider.dart';

class GameResultScreen extends StatefulWidget {
  const GameResultScreen({super.key});
  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  bool _saved = false;
  @override
  Widget build(BuildContext context) {
    final result = context.watch<QuizProvider>();
    if (!_saved) {
      _saved = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted)
          context.read<LearningProgressProvider>().updateQuizScore(
            result.scorePoints,
          );
      });
    }
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CompiHeader(
                  title: 'Hasil Latihan',
                  onBack: () => Navigator.pop(context),
                ),
                const SizedBox(height: 25),
                const Icon(
                  Icons.emoji_events,
                  color: AppColors.yellow,
                  size: 130,
                ),
                const Text(
                  'Tantangan Selesai!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CompiPanel(
                  child: Column(
                    children: [
                      Text(
                        '${result.scorePoints}/100',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 54,
                        ),
                      ),
                      Text(
                        '${result.correctCount} dari ${result.resultTotal} jawaban benar',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        result.isMatchResult
                            ? 'Match the Component'
                            : 'Component Challenge',
                        style: const TextStyle(color: AppColors.textGray),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CompiButton(
                  label: 'Kembali ke Menu Praktik',
                  icon: Icons.sports_esports,
                  onPressed: () {
                    result.resetQuiz();
                    Navigator.pop(context);
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
