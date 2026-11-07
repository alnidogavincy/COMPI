import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../core/app_colors.dart';
import '../../providers/learning_progress_provider.dart';

class LearningAchievementList extends StatelessWidget {
  const LearningAchievementList({super.key, required this.progress});
  final LearningProgressProvider progress;

  @override
  Widget build(BuildContext context) {
    final total = dummyMaterials.length;
    final done =
        dummyMaterials.where((m) => progress.isMaterialCompleted(m.id)).length;
    return Column(
      children: [
        _row(
          'Perjalanan Belajarmu',
          '$done dari $total materi selesai',
          done,
          total,
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text(
              'Progres per komponen',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            children:
                dummyComponents.map((component) {
                  final lessons =
                      dummyMaterials
                          .where((m) => m.componentId == component.id)
                          .toList();
                  final completed =
                      lessons
                          .where((m) => progress.isMaterialCompleted(m.id))
                          .length;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _row(
                      component.name,
                      '$completed dari ${lessons.length} materi selesai',
                      completed,
                      lessons.length,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _row(String title, String subtitle, int done, int total) {
    final value = total == 0 ? 0.0 : (done / total).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color:
                  done > 0
                      ? AppColors.orange.withValues(alpha: .16)
                      : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              done == total && total > 0
                  ? Icons.emoji_events_rounded
                  : Icons.auto_stories_rounded,
              color: done > 0 ? AppColors.orange : AppColors.textGray,
            ),
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            label: '$title, ${(value * 100).round()} persen selesai',
            child: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      color: AppColors.primary,
                      backgroundColor: AppColors.primaryLight,
                    ),
                  ),
                  Text(
                    '${(value * 100).round()}%',
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
