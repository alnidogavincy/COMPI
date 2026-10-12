import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/component_model.dart';
import '../../../data/models/learning_material_model.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../core/hardware_image.dart';
import '../../providers/learning_progress_provider.dart';
import '../explore_3d/explore_3d_screen.dart';
import '../games/quiz_screen.dart';
import '../../providers/quiz_provider.dart';

class MaterialDetailScreen extends StatelessWidget {
  final ComponentModel component;
  final LearningMaterialModel material;
  const MaterialDetailScreen({
    super.key,
    required this.component,
    required this.material,
  });
  @override
  Widget build(BuildContext context) {
    final progress = context.watch<LearningProgressProvider>();
    final lessons =
        dummyMaterials.where((m) => m.componentId == component.id).toList();
    final completed = progress.isMaterialCompleted(material.id);
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CompiHeader(
                  title: 'Materi Pembelajaran',
                  onBack: () => Navigator.pop(context),
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.cyan],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.yellow, width: 3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: HardwareImage(component: component, height: 180),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  component.name,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 27,
                  ),
                ),
                Text(
                  'SMK TKJ • Materi Dasar • ${component.category}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                SectionBanner(icon: Icons.description, title: material.title),
                CompiPanel(
                  child: Text(
                    material.content,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const SectionBanner(
                  icon: Icons.settings,
                  title: 'Fungsi & Karakteristik',
                ),
                CompiPanel(
                  child: Text(
                    component.fullDescription,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
                if (component.hotspots.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const SectionBanner(
                    icon: Icons.place,
                    title: 'Bagian Komponen',
                  ),
                  CompiPanel(
                    child: Column(
                      children:
                          component.hotspots
                              .map(
                                (h) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(
                                    Icons.memory,
                                    color: AppColors.primary,
                                  ),
                                  title: Text(h.label),
                                  subtitle: Text(h.description),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                CompiButton(
                  label:
                      completed
                          ? 'Sudah Selesai Dibaca'
                          : 'Tandai Selesai Dibaca',
                  icon: Icons.check_circle,
                  onPressed:
                      completed
                          ? null
                          : () => context
                              .read<LearningProgressProvider>()
                              .completeMaterial(material.id),
                ),
                const SizedBox(height: 8),
                if (component.hasModel)
                  CompiButton(
                    label: 'Lihat Model 3D',
                    icon: Icons.view_in_ar,
                    secondary: true,
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => Explore3DScreen(
                                  initialComponent: component,
                                ),
                          ),
                        ),
                  ),
                if (lessons.length > 1) ...[
                  const SizedBox(height: 12),
                  const SectionBanner(
                    icon: Icons.menu_book,
                    title: 'Materi Lainnya',
                  ),
                  CompiPanel(
                    child: Column(
                      children:
                          lessons
                              .where((m) => m.id != material.id)
                              .map(
                                (m) => ListTile(
                                  title: Text(m.title),
                                  trailing: const Icon(Icons.arrow_forward),
                                  onTap:
                                      () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => MaterialDetailScreen(
                                                component: component,
                                                material: m,
                                              ),
                                        ),
                                      ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                CompiButton(
                  label: 'Lanjut ke Kuis',
                  icon: Icons.sports_esports,
                  secondary: true,
                  onPressed: () {
                    final questions =
                        dummyQuizQuestions
                            .where((q) => q.componentId == component.id)
                            .toList();
                    if (questions.isEmpty) return;
                    context.read<QuizProvider>().loadQuiz(questions);
                    Navigator.push(
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
