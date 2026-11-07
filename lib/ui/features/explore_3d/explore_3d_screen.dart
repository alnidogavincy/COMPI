import 'package:flutter/material.dart';
import 'hardware_model_viewer.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/component_model.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/audio_provider.dart';
import '../../providers/learning_progress_provider.dart';

class Explore3DScreen extends StatefulWidget {
  final ComponentModel? initialComponent;
  const Explore3DScreen({super.key, this.initialComponent});
  @override
  State<Explore3DScreen> createState() => _Explore3DScreenState();
}

class _Explore3DScreenState extends State<Explore3DScreen> {
  late ComponentModel _active;
  int _viewerRevision = 0;
  @override
  void initState() {
    super.initState();
    _active =
        widget.initialComponent?.hasModel == true
            ? widget.initialComponent!
            : dummyComponents.firstWhere((c) => c.hasModel);
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<LearningProgressProvider>();
    final lessons =
        dummyMaterials.where((m) => m.componentId == _active.id).toList();
    final allLessonsCompleted =
        lessons.isNotEmpty &&
        lessons.every((lesson) => progress.isMaterialCompleted(lesson.id));
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CompiHeader(
                  title: 'Eksplorasi Hardware 3D',
                  onBack: () => Navigator.pop(context),
                  action: PhysicalButton(
                    child: IconButton.filled(
                      tooltip: 'Reset sudut',
                      onPressed: () => setState(() => _viewerRevision++),
                      icon: const Icon(Icons.refresh),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * .43,
                  constraints: const BoxConstraints(
                    minHeight: 270,
                    maxHeight: 430,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.yellow, width: 4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: HardwareModelViewer(
                            key: ValueKey('${_active.id}-$_viewerRevision'),
                            src: _active.modelPath,
                            name: _active.name,
                          ),
                        ),
                        const Positioned(
                          left: 12,
                          top: 12,
                          child: IgnorePointer(
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.symmetric(horizontal: 6),
                              label: Text(
                                'MODEL 3D INTERAKTIF',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 12,
                          right: 12,
                          bottom: 12,
                          child: Text(
                            'Geser untuk memutar • Cubit untuk memperbesar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const SectionBanner(
                  icon: Icons.menu_book,
                  title: 'Materi Pembelajaran Lengkap',
                ),
                ...lessons.map(
                  (lesson) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CompiPanel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            lesson.title,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            lesson.content,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_active.hotspots.isNotEmpty) ...[
                  const SectionBanner(
                    icon: Icons.place,
                    title: 'Bagian Komponen',
                  ),
                  CompiPanel(
                    child: Column(
                      children:
                          _active.hotspots
                              .map(
                                (hotspot) => PhysicalButton(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(
                                      Icons.memory,
                                      color: AppColors.primary,
                                    ),
                                    title: Text(hotspot.label),
                                    subtitle: Text(hotspot.description),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
                if (lessons.isNotEmpty)
                  CompiButton(
                    label:
                        allLessonsCompleted
                            ? 'Semua Materi Sudah Selesai Dibaca'
                            : 'Tandai Selesai Dibaca',
                    onPressed:
                        allLessonsCompleted
                            ? null
                            : () {
                              for (final lesson in lessons) {
                                progress.completeMaterial(lesson.id);
                              }
                              context.read<AudioProvider?>()?.effect('star');
                            },
                  ),
                if (lessons.isNotEmpty) const SizedBox(height: 14),
                const SectionBanner(
                  icon: Icons.view_in_ar,
                  title: 'Pilih Model Lain',
                ),
                CompiPanel(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        dummyComponents
                            .where((component) => component.hasModel)
                            .map(
                              (component) => PhysicalButton(
                                child: ChoiceChip(
                                  label: Text(component.name),
                                  selected: component.id == _active.id,
                                  selectedColor: AppColors.yellow,
                                  onSelected:
                                      (_) => setState(() {
                                        _active = component;
                                        _viewerRevision++;
                                      }),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Pilih model komponen untuk mempelajari bentuknya dari berbagai sudut.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
