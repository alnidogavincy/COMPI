import '../../core/halftone_paper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/learning_progress_provider.dart';
import '../profile/profile_screen.dart';
import 'match_up_instructions_screen.dart';
import 'quiz_instructions_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final best = context.watch<LearningProgressProvider>().highestScore;
    return CircuitBackground(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.paddingOf(context).bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CompiBrandHeader(
                title: 'Latihan Perangkat Keras',
                action: PhysicalButton(
                  child: IconButton.filled(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        ),
                    icon: const StudentAvatar(),
                  ),
                ),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFF167AC6),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.yellow, width: 4),
                ),
                child: CustomPaint(
                  painter: const HalftonePaperPainter(),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/practice_trophy.png',
                          height: 104,
                          width: 104,
                          fit: BoxFit.contain,
                          cacheWidth: 260,
                          semanticLabel: 'Piala tantangan',
                        ),
                        const Text(
                          'UJI PEMAHAMAN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 29,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'Uji pengetahuanmu tentang perangkat keras komputer!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Skor tertinggi: $best/100',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                title: 'Latihan Pemahaman',
                description:
                    'Asah pemahamanmu dengan soal dari seluruh materi pembelajaran.',
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuizInstructionsScreen(),
                    ),
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
                      MaterialPageRoute(
                        builder: (_) => const MatchUpInstructionsScreen(),
                      ),
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
                child: PhysicalButton(
                  child: ElevatedButton(
                    onPressed: action,
                    child: const Text('Mulai'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
