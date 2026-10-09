import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/component_model.dart';
import '../learning/material_detail_screen.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';

class Explore3DScreen extends StatefulWidget {
  final ComponentModel? initialComponent;

  const Explore3DScreen({super.key, this.initialComponent});

  @override
  State<Explore3DScreen> createState() => _Explore3DScreenState();
}

class _Explore3DScreenState extends State<Explore3DScreen> {
  late ComponentModel _activeComponent;

  @override
  void initState() {
    super.initState();
    _activeComponent = widget.initialComponent ?? dummyComponents.first;
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('COMPI', style: AppTypography.heading3.copyWith(fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w900)),
                      const SizedBox(width: 8),
                      Text('Explore 3D', style: AppTypography.subtitle),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person, size: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            
            // ── Area Viewer 3D (Atas) ──
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ModelViewer(
                      backgroundColor: AppColors.background,
                      src: _activeComponent.modelPath,
                      alt: "3D Model of ${_activeComponent.name}",
                      autoRotate: true,
                      cameraControls: true,
                    ),
                  ),
                  // Title & Badge X-Ray
                  Positioned(
                    top: 16, left: 24, right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Explore 3D PC', style: AppTypography.heading2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  const Icon(Icons.qr_code_scanner, size: 14, color: AppColors.primary),
                                  const SizedBox(width: 4),
                                  Text('X-Ray', style: AppTypography.tag),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Jelajahi, putar, dan perbesar untuk melihat\ndetail setiap komponen.', style: AppTypography.caption.copyWith(height: 1.5)),
                        const SizedBox(height: 16),
                        
                        // Action Chips
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              _ActionChip(icon: Icons.threed_rotation, label: '360° Rotasi'),
                              SizedBox(width: 8),
                              _ActionChip(icon: Icons.pinch, label: 'Pinch Zoom'),
                              SizedBox(width: 8),
                              _ActionChip(icon: Icons.touch_app, label: 'Ketuk Pin Hotspot'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Floating Button "Lihat Komponen Lain" di dasar viewer
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.view_in_ar, color: AppColors.primary, size: 18),
                            const SizedBox(width: 8),
                            Text('Lihat Komponen Lain', style: AppTypography.subtitle.copyWith(color: AppColors.primary, fontSize: 12)),
                            const SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down, color: AppColors.primaryDark),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // ── Area Info (Bawah) ──
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, -5))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4))),
                    ),
                    const SizedBox(height: 24),
                    
                    // Judul Komponen
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(16)),
                          child: const Icon(Icons.memory, color: Color(0xFF2954E3)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('KOMPONEN AKTIF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal)),
                                  const SizedBox(width: 6),
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.teal, shape: BoxShape.circle)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(_activeComponent.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)), maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                          child: Text('Modul #02', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Deskripsi
                    Text(
                      _activeComponent.fullDescription,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    
                    // Specs Grid
                    _activeComponent.specs == null ? const SizedBox.shrink() : Column(
                        children: [
                          Row(
                            children: _activeComponent.specs!.entries.map((entry) {
                              return Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4FA),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(entry.key, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                      const SizedBox(height: 4),
                                      Text(entry.value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF2954E3))),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    // Alert K3
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.lightBlue[50], borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user_outlined, size: 20, color: Colors.teal),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text('Pastikan kancing pengunci (DIMM lock) telah terbuka sebelum memasang.', style: TextStyle(fontSize: 12, color: Colors.teal[800])),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Tombol Materi
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final material = dummyMaterials.firstWhere(
                            (m) => m.componentId == _activeComponent.id,
                            orElse: () => dummyMaterials.first,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MaterialDetailScreen(component: _activeComponent, material: material)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2954E3),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('PELAJARI MATERI LENGKAP', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2954E3)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }
}
