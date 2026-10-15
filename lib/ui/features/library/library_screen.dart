import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/component_model.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../core/hardware_image.dart';
import '../explore_3d/explore_3d_screen.dart';
import '../learning/material_detail_screen.dart';
import '../profile/profile_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _search = TextEditingController();
  String _filter = 'Semua';
  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Semua',
      ...{for (final c in dummyComponents) c.category},
    ];
    final visible =
        dummyComponents.where((c) {
          final q = _search.text.trim().toLowerCase();
          return (_filter == 'Semua' || c.category == _filter) &&
              (q.isEmpty ||
                  c.name.toLowerCase().contains(q) ||
                  c.shortDescription.toLowerCase().contains(q));
        }).toList();
    return CircuitBackground(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CompiHeader(
                      title: 'Library Materi',
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
                    const Text(
                      'Kenali & pelajari arsitektur hardware PC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Cari materi, socket, DDR...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            categories
                                .map(
                                  (category) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ChoiceChip(
                                      label: Text(category),
                                      selected: _filter == category,
                                      onSelected:
                                          (_) => setState(
                                            () => _filter = category,
                                          ),
                                      selectedColor: AppColors.yellow,
                                      backgroundColor: AppColors.surface,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SectionBanner(
                      icon: Icons.menu_book,
                      title: 'Materi Tersedia (${visible.length})',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            if (visible.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CompiPanel(
                    child: Text('Tidak ada materi yang cocok.'),
                  ),
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              sliver: SliverLayoutBuilder(
                builder:
                    (context, constraints) => SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            constraints.crossAxisExtent < 320
                                ? 1
                                : (constraints.crossAxisExtent / 250)
                                    .floor()
                                    .clamp(2, 4),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent:
                            160 +
                            125 * MediaQuery.textScalerOf(context).scale(1),
                      ),
                      itemCount: visible.length,
                      itemBuilder:
                          (context, i) => _ComponentCard(component: visible[i]),
                    ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                child: CompiButton(
                  label: 'Eksplorasi Model 3D',
                  icon: Icons.view_in_ar,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Explore3DScreen(),
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComponentCard extends StatelessWidget {
  final ComponentModel component;
  const _ComponentCard({required this.component});
  @override
  Widget build(BuildContext context) {
    final materials =
        dummyMaterials.where((m) => m.componentId == component.id).toList();
    return InkWell(
      onTap:
          materials.isEmpty
              ? null
              : () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => MaterialDetailScreen(
                        component: component,
                        material: materials.first,
                      ),
                ),
              ),
      child: CompiPanel(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Stack(
                children: [
                  HardwareImage(component: component, height: 140),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        component.hasModel ? '3D' : 'Materi',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${materials.length} MATERI',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    component.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    component.shortDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
