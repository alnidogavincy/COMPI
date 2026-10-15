import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../../data/model_credits.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../core/compi_widgets.dart';

class ModelCreditsScreen extends StatelessWidget {
  const ModelCreditsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CircuitBackground(
      child: SafeArea(
        child: Column(
          children: [
            CompiHeader(
              title: 'Kredit Model 3D',
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  const CompiPanel(
                    child: Text(
                      'Terima kasih kepada para kreator model 3D. Nama pembuat, lisensi, dan sumber asli setiap model tersedia di bawah ini. Teks dan alamat sumber dapat disalin.',
                      style: TextStyle(color: AppColors.ink, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (final entry in modelCredits.entries) ...[
                    CompiPanel(
                      child: ExpansionTile(
                        key: PageStorageKey(entry.key),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: const EdgeInsets.only(bottom: 8),
                        leading: const Icon(
                          Icons.view_in_ar,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          dummyComponents
                                  .where((c) => c.modelPath == entry.key)
                                  .firstOrNull
                                  ?.name ??
                              entry.value.split('\n').first,
                          style: AppTypography.heading3.copyWith(
                            color: AppColors.ink,
                          ),
                        ),
                        subtitle: Text(entry.value.split('\n').first),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SelectableText(
                              entry.value,
                              key: PageStorageKey('credit-text-${entry.key}'),
                              style: const TextStyle(
                                color: AppColors.textGray,
                                fontSize: 13,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
