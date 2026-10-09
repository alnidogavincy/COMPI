import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/quiz_provider.dart';
import '../../../data/repositories/content_repository.dart';
import '../explore_3d/explore_3d_screen.dart';
import '../games/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<LearningProgressProvider>();
    final contentRepo = context.read<ContentRepository>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header APP ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('COMPI', style: AppTypography.heading3.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900)),
                      const SizedBox(width: 8),
                      Text('Home', style: AppTypography.subtitle),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person, size: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Profil Pengguna ──
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 14, height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Halo, Vika! 👋', style: AppTypography.heading3),
                        Text('SMK TKJ Kelas X • Modul Perakitan', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_none, size: 20, color: AppColors.textDark),
                        Positioned(
                          right: 0, top: 0,
                          child: CircleAvatar(radius: 4, backgroundColor: AppColors.error),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Progres Belajar ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Progres Belajar', style: AppTypography.subtitle),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text('${progressProvider.highestScore} XP Terkumpul', style: AppTypography.tag),
                          ),
                          const SizedBox(height: 12),
                          Text('Progress Belajar: ${(progressProvider.completedCount / 10 * 100).toInt()}%', style: AppTypography.heading3.copyWith(fontSize: 18)),
                          const SizedBox(height: 4),
                          Text('${progressProvider.completedCount} dari 10 Materi Perakitan Selesai', style: AppTypography.caption),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.fiber_manual_record, size: 12, color: AppColors.success),
                              const SizedBox(width: 4),
                              Text('Status: Aktif Membaca Socket AM4', style: AppTypography.caption.copyWith(color: AppColors.success)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70, height: 70,
                          child: CircularProgressIndicator(
                            value: progressProvider.completedCount / 10,
                            strokeWidth: 8,
                            backgroundColor: AppColors.primaryLight,
                            color: AppColors.primary,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${(progressProvider.completedCount / 10 * 100).toInt()}%', style: AppTypography.heading3.copyWith(color: AppColors.primary, fontSize: 16)),
                            const Text('Target', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textGray)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Akses Cepat Praktik ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.rocket_launch, color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Text('Akses Cepat', style: AppTypography.heading3.copyWith(fontSize: 18)),
                    ],
                  ),
                  Text('Panduan Alat', style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _QuickAccessCard(
                      title: 'Explore 3D PC',
                      subtitle: '3D Lab Interaktif',
                      icon: Icons.view_in_ar,
                      color: AppColors.primary,
                      textColor: Colors.white,
                      buttonText: 'Mulai Eksplorasi →',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Explore3DScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _QuickAccessCard(
                      title: 'Tantangan Kuis',
                      subtitle: 'Uji Kemampuan',
                      icon: Icons.psychology,
                      color: AppColors.primaryLight,
                      textColor: AppColors.textDark,
                      buttonText: 'Ikuti Kuis →',
                      onTap: () async {
                        final questions = await contentRepo.getQuizQuestions();
                        if (context.mounted) {
                          context.read<QuizProvider>().loadQuiz(questions);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const QuizScreen()),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ── Lanjutkan Belajar ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lanjutkan Belajar', style: AppTypography.heading3.copyWith(fontSize: 18)),
                  Text('Lihat Semua >', style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _ContinueLearningCard(
                      title: 'Motherboard',
                      subtitle: 'Arsitektur PCB',
                      description: 'Form factor ATX & Chipset',
                      icon: Icons.developer_board,
                      progress: 1.0, // Selesai
                    ),
                    const SizedBox(width: 16),
                    _ContinueLearningCard(
                      title: 'Processor (CPU)',
                      subtitle: 'Unit Pemrosesan',
                      description: 'Inti pemrosesan komputer',
                      icon: Icons.memory,
                      progress: 0.65,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // ── Tips Teknisi ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('TIPS TEKNISI HARI INI • SOP K3', style: AppTypography.tag.copyWith(color: AppColors.primaryDark)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Selalu gunakan gelang anti-statis (ESD wrist strap) saat menyentuh komponen internal PC untuk mencegah kerusakan akibat listrik statis.',
                      style: AppTypography.body.copyWith(color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: textColor == Colors.white ? Colors.white.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: textColor == Colors.white ? Colors.white : AppColors.primary, size: 24),
            ),
            const SizedBox(height: 16),
            Text(subtitle, style: AppTypography.caption.copyWith(color: textColor.withOpacity(0.8), fontSize: 10)),
            const SizedBox(height: 4),
            Text(title, style: AppTypography.subtitle.copyWith(color: textColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(buttonText, style: AppTypography.caption.copyWith(color: textColor == Colors.white ? Colors.white : AppColors.primary, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final double progress;

  const _ContinueLearningCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress >= 1.0;
    
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF2954E3), size: 20),
              ),
              isCompleted
                ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF2954E3)),
                      const SizedBox(width: 4),
                      Text('Selesai', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${(progress * 100).toInt()}% Progress', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal[700])),
                ),
            ],
          ),
          const Spacer(),
          Text(subtitle, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 16),
          !isCompleted ? const SizedBox.shrink() : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Review 3D', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8EEFC),
                  foregroundColor: const Color(0xFF1E293B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          isCompleted ? const SizedBox.shrink() : ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: const Color(0xFF2954E3),
                minHeight: 6,
              ),
            ),
          isCompleted ? const SizedBox.shrink() : const SizedBox(height: 8),
          isCompleted ? const SizedBox.shrink() : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow, size: 16, color: Colors.white),
                label: const Text('Lanjutkan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2954E3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
