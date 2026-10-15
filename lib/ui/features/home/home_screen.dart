import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../core/app_typography.dart';
import '../../core/hardware_showcase.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/student_provider.dart';
import '../explore_3d/explore_3d_screen.dart';
import '../games/games_screen.dart';
import '../learning/material_detail_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final progress = context.watch<LearningProgressProvider>();
    final name = context.watch<StudentProvider>().identity;
    final total = dummyMaterials.length;
    final done = progress.completedCount.clamp(0, total);
    final next =
        dummyMaterials
            .where((m) => !progress.isMaterialCompleted(m.id))
            .firstOrNull;
    final nextComponent =
        next == null
            ? null
            : dummyComponents
                .where((c) => c.id == next.componentId)
                .firstOrNull;
    return CircuitBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CompiHeader(
                title: 'SMK TKJ 3D',
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
              Text(
                'Halo, ${name.isEmpty ? 'Siswa' : name}! 👋',
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 30,
                  fontFamily: AppTypography.displayFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'Selamat datang di aplikasi pembelajaran interaktif komponen komputer.',
                style: TextStyle(color: AppColors.primaryDark, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.cyan],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.yellow, width: 4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BELAJAR KOMPONEN\nKOMPUTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppTypography.displayFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                        height: 1.2,
                      ),
                    ),
                    const Text(
                      'Secara Interaktif',
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const HardwareShowcase(),
                    const SizedBox(height: 12),
                    CompiButton(
                      label: 'Mulai Eksplorasi 3D',
                      icon: Icons.play_arrow,
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Explore3DScreen(),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SectionBanner(
                icon: Icons.bar_chart_rounded,
                title: 'Progress Belajar',
              ),
              CompiPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${total == 0 ? 0 : (done * 100 ~/ total)}%',
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '$done dari $total materi selesai',
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: total == 0 ? 0 : done / total,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.orange,
                      backgroundColor: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SectionBanner(icon: Icons.settings, title: 'Akses Cepat'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _QuickCard(
                      icon: Icons.view_in_ar,
                      title: 'Eksplorasi 3D',
                      detail: 'Putar dan perbesar model',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Explore3DScreen(),
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _QuickCard(
                      icon: Icons.sports_esports,
                      title: 'Tantangan Kuis',
                      detail: 'Uji pemahamanmu',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GamesScreen(),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
              if (next != null && nextComponent != null) ...[
                const SizedBox(height: 16),
                const SectionBanner(
                  icon: Icons.menu_book,
                  title: 'Lanjutkan Belajar',
                ),
                InkWell(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MaterialDetailScreen(
                                component: nextComponent,
                                material: next,
                              ),
                        ),
                      ),
                  child: CompiPanel(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.memory,
                          color: AppColors.primary,
                          size: 42,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nextComponent.name,
                                style: const TextStyle(
                                  color: AppColors.ink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                next.title,
                                style: const TextStyle(
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const CompiPanel(
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: AppColors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tips: kenali fungsi dan posisi komponen sebelum memulai latihan.',
                        style: TextStyle(color: AppColors.ink),
                      ),
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

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final VoidCallback onTap;
  const _QuickCard({
    required this.icon,
    required this.title,
    required this.detail,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.cyan, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.yellow, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            detail,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
