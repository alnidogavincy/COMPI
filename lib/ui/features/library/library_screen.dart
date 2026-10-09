import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../../data/models/component_model.dart';
import '../../../data/repositories/content_repository.dart';
import '../learning/material_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ComponentModel> _allComponents = [];
  List<ComponentModel> _filteredComponents = [];
  String _selectedFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    _loadComponents();
  }
  
  Future<void> _loadComponents() async {
    final repo = context.read<ContentRepository>();
    final components = await repo.getComponents();
    if (mounted) {
      setState(() {
        _allComponents = components;
        _filteredComponents = components;
      });
    }
  }

  void _filterComponents(String query) {
    if (query.isEmpty && _selectedFilter == 'Semua') {
      setState(() {
        _filteredComponents = _allComponents;
      });
    } else {
      setState(() {
        _filteredComponents = _allComponents.where((c) {
          final matchesQuery = c.name.toLowerCase().contains(query.toLowerCase()) || 
                               c.shortDescription.toLowerCase().contains(query.toLowerCase());
          final matchesCategory = _selectedFilter == 'Semua' || c.category == _selectedFilter;
          return matchesQuery && matchesCategory;
        }).toList();
      });
    }
  }

  void _setFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      _filterComponents(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('COMPI', style: AppTypography.heading3.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900)),
                      const SizedBox(width: 8),
                      Text('Library', style: AppTypography.subtitle),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person, size: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            
            // ── Title & Search ──
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('KATALOG 3D', style: AppTypography.tag.copyWith(color: Colors.white)),
                      ),
                      const SizedBox(width: 8),
                      Text('${_allComponents.length} Modul Lengkap', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Library Materi', style: AppTypography.heading2),
                  const SizedBox(height: 4),
                  Text('Kenali & pelajari arsitektur hardware PC SMK TKJ', style: AppTypography.body),
                  const SizedBox(height: 24),
                  
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterComponents,
                      decoration: InputDecoration(
                        hintText: 'Cari materi, socket, DDR...',
                        hintStyle: TextStyle(color: AppColors.textGray.withOpacity(0.5), fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                        suffixIcon: const Icon(Icons.tune, color: AppColors.textGray),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FilterChip(label: 'Semua', isSelected: _selectedFilter == 'Semua', onTap: () => _setFilter('Semua')),
                        const SizedBox(width: 8),
                        _FilterChip(label: 'Komponen Utama', isSelected: _selectedFilter == 'Komponen Utama', onTap: () => _setFilter('Komponen Utama')),
                        const SizedBox(width: 8),
                        _FilterChip(label: 'Penyimpanan', isSelected: _selectedFilter == 'Penyimpanan', onTap: () => _setFilter('Penyimpanan')),
                        const SizedBox(width: 8),
                        _FilterChip(label: 'Daya', isSelected: _selectedFilter == 'Daya', onTap: () => _setFilter('Daya')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // ── Grid of Components ──
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('MODUL PRAKTIK 3D', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Menampilkan ${_filteredComponents.length} Komponen', style: AppTypography.tag),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _filteredComponents.isEmpty
                          ? Center(child: Text('Tidak ada komponen ditemukan', style: AppTypography.body))
                          : GridView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: _filteredComponents.length,
                              itemBuilder: (context, index) {
                                final component = _filteredComponents[index];
                                return _LibraryCard(component: component);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textGray,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  final ComponentModel component;

  const _LibraryCard({required this.component});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final repo = context.read<ContentRepository>();
        final materials = await repo.getMaterialsForComponent(component.id);
        if (context.mounted && materials.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaterialDetailScreen(
                component: component,
                material: materials.first, // Open the first material for now
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        _getIconForComponent(component.id),
                        size: 60,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    Positioned(
                      top: 10, left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.view_in_ar, size: 10, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text('3D', style: AppTypography.tag.copyWith(fontSize: 9)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text area
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          component.name,
                          style: AppTypography.subtitle.copyWith(fontSize: 14, color: AppColors.textDark),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          component.category,
                          style: AppTypography.caption.copyWith(fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.schedule, size: 12, color: AppColors.textGray),
                            const SizedBox(width: 4),
                            Text('15 Mnt', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForComponent(String id) {
    switch (id) {
      case 'motherboard': return Icons.developer_board;
      case 'cpu': return Icons.memory;
      case 'ram': return Icons.storage;
      case 'vga': return Icons.developer_board_off; 
      default: return Icons.computer;
    }
  }
}
