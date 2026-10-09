import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../data/dummy_data.dart';
import '../../../data/model_credits.dart';
import '../../../data/models/component_model.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../learning/material_detail_screen.dart';

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
    final lessons =
        dummyMaterials.where((m) => m.componentId == _active.id).toList();
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: Column(
            children: [
              CompiHeader(
                title: 'Eksplorasi Hardware 3D',
                onBack: () => Navigator.pop(context),
                action: IconButton.filled(
                  tooltip: 'Reset sudut',
                  onPressed: () => setState(() => _viewerRevision++),
                  icon: const Icon(Icons.refresh),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                child: ModelViewer(
                                  key: ValueKey(
                                    '${_active.id}-$_viewerRevision',
                                  ),
                                  src: _active.modelPath,
                                  alt: 'Model 3D ${_active.name}',
                                  cameraControls: true,
                                  autoRotate: false,
                                  backgroundColor: AppColors.primaryDark,
                                ),
                              ),
                              const Positioned(
                                left: 12,
                                top: 12,
                                child: Chip(label: Text('MODEL 3D INTERAKTIF')),
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
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 4,
                                      ),
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
                        icon: Icons.settings,
                        title: 'Komponen Terfokus',
                      ),
                      CompiPanel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _active.name,
                              style: const TextStyle(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _active.fullDescription,
                              style: const TextStyle(
                                color: AppColors.textGray,
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                            if (_active.specs != null) ...[
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    _active.specs!.entries
                                        .map(
                                          (e) => Chip(
                                            label: Text('${e.key}: ${e.value}'),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                            const SizedBox(height: 12),
                            CompiButton(
                              label: 'Pelajari Materi Lengkap',
                              icon: Icons.menu_book,
                              onPressed:
                                  lessons.isEmpty
                                      ? null
                                      : () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => MaterialDetailScreen(
                                                component: _active,
                                                material: lessons.first,
                                              ),
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
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
                                    (component) => ChoiceChip(
                                      label: Text(component.name),
                                      selected: component.id == _active.id,
                                      selectedColor: AppColors.yellow,
                                      onSelected:
                                          (_) => setState(() {
                                            _active = component;
                                            _viewerRevision++;
                                          }),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (modelCredits.containsKey(_active.modelPath))
                        CompiPanel(
                          child: ExpansionTile(
                            title: const Text('Kredit model 3D'),
                            children: [
                              SelectableText(
                                modelCredits[_active.modelPath]!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Text(
                        'Pilih model komponen untuk mempelajari bentuknya dari berbagai sudut.',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
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
