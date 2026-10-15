import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/quiz_provider.dart';
import '../profile/profile_screen.dart';
import 'match_up_screen.dart';
import 'quiz_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final best = context.watch<LearningProgressProvider>().highestScore;
    return CircuitBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CompiHeader(
                title: 'Latihan Perangkat Keras',
                action: IconButton.filled(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      ),
                  icon: const Icon(Icons.person_outline),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryDark,
                      AppColors.primary,
                      AppColors.cyan,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.yellow, width: 4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: AppColors.yellow,
                      size: 70,
                    ),
                    const Text(
                      'QUIZ CHALLENGE',
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 29,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Uji pengetahuanmu tentang perangkat keras komputer!',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Skor tertinggi: $best/100',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SectionBanner(
                icon: Icons.settings,
                title: 'Pilih Mode Tantangan',
              ),
              const SizedBox(height: 10),
              _ModeCard(
                icon: Icons.memory,
                title: 'Component Challenge',
                description:
                    'Pilih komponen berdasarkan fungsi atau deskripsinya.',
                action: () {
                  context.read<QuizProvider>().loadQuiz(dummyQuizQuestions);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ModeCard(
                icon: Icons.extension,
                title: 'Match the Component',
                description: 'Cocokkan komponen dengan nama yang tepat.',
                action:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MatchUpScreen()),
                    ),
              ),
              const SizedBox(height: 14),
              const CompiPanel(
                child: Text(
                  'Dua mode latihan tersedia. Skor tertinggi tersimpan di perangkat ini.',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback action;
  const _ModeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.action,
  });
  @override
  Widget build(BuildContext context) => CompiPanel(
    child: Row(
      children: [
        Container(
          width: 76,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.cyan, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 44),
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
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: AppColors.textGray, fontSize: 12),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: action,
                  child: const Text('Mulai →'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
