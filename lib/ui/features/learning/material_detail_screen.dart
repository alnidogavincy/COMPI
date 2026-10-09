import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../../data/models/component_model.dart';
import '../../../data/models/learning_material_model.dart';
import '../../providers/learning_progress_provider.dart';
import '../explore_3d/explore_3d_screen.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Detail Materi', style: AppTypography.heading3.copyWith(fontSize: 18)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text('Materi', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    const SizedBox(width: 8),
                    Text('• ${component.category}', style: AppTypography.caption),
                  ],
                ),
                Text('35% selesai', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: 0.35, backgroundColor: AppColors.border, color: AppColors.primary, minHeight: 4),
            ),
            const SizedBox(height: 24),

            // Audio Player (Dummy)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.volume_up, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Audio Narasi Pembelajaran', style: AppTypography.subtitle.copyWith(fontSize: 12)),
                        Text('02:14 • Narator COMPI AI', style: AppTypography.caption.copyWith(fontSize: 10)),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark_border, color: AppColors.textGray, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Topic Tags
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                  child: Text(component.name, style: AppTypography.tag),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                  child: Text(component.category, style: AppTypography.tag),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3D Model Viewer Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Explore3DScreen(initialComponent: component)),
                );
              },
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: ModelViewer(
                          backgroundColor: Colors.white,
                          src: component.modelPath,
                          alt: "3D Model of ${component.name}",
                          autoRotate: true,
                          cameraControls: false, // disable controls in this view so we can tap to full screen
                          interactionPrompt: InteractionPrompt.none,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(12), 
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.threed_rotation, size: 12, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text('Ketuk untuk Inspeksi 3D', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Specs Row
            if (component.specs != null) ...[
              Row(
                children: component.specs!.entries.map((entry) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
                      child: Column(
                        children: [
                          Text(entry.key, style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(entry.value.split(' ').first, style: AppTypography.heading3.copyWith(fontSize: 16, color: AppColors.primary)),
                          Text(entry.value.split(' ').length > 1 ? entry.value.split(' ').last : '', style: AppTypography.caption.copyWith(fontSize: 8, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
            ],

            // Text Content Section
            Row(
              children: [
                Container(width: 4, height: 16, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 8),
                Text(material.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: AppTypography.body.copyWith(height: 1.6),
                      children: [
                        TextSpan(text: component.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                        const TextSpan(text: ' adalah '),
                        TextSpan(text: material.content),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, size: 18, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Informasi tambahan untuk ${component.name}. Perhatikan panduan keselamatan.',
                            style: AppTypography.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Bottom Action
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.psychology, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text('UJI PEMAHAMAN CEPAT', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Apakah Anda sudah memahami fungsi dari ${component.name}?', style: AppTypography.caption.copyWith(color: Colors.white.withOpacity(0.9))),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<LearningProgressProvider>().completeMaterial(material.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check_circle_outline, color: AppColors.primary),
                      label: Text('Tandai Selesai Dibaca', style: AppTypography.subtitle.copyWith(color: AppColors.primary)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
