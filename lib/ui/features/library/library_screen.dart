import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/component_model.dart';
import '../explore_3d/explore_3d_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'COMPI',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2954E3)),
                      ),
                      Text('TKJ Hardware 3D', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Library', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700])),
                      const SizedBox(width: 12),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.person, size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Katalog
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EEFC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.view_in_ar, size: 12, color: Color(0xFF2954E3)),
                              SizedBox(width: 4),
                              Text('KATALOG 3D', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('8 Modul Lengkap', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    const Text('Library Materi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    const SizedBox(height: 8),
                    Text(
                      'Kenali dan pelajari setiap komponen komputer dengan visual yang menarik dan interaktif.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    
                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari materi komponen...',
                              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                              prefixIcon: const Icon(Icons.search, color: Color(0xFF2954E3)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.grey[200]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: const Icon(Icons.tune, color: Color(0xFF2954E3)),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _FilterChip(label: 'Semua', icon: Icons.grid_view, isSelected: true),
                          const SizedBox(width: 12),
                          _FilterChip(label: 'Komponen Inti', icon: Icons.settings, isSelected: false),
                          const SizedBox(width: 12),
                          _FilterChip(label: 'Penyimpanan', icon: Icons.save, isSelected: false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Header Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('MODUL PRAKTIK 3D', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(6)),
                          child: Text('Menampilkan 8 Komponen', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Grid View
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75, // Adjust for card height
                      ),
                      itemCount: dummyComponents.length, // menggunakan data dummy yang ada
                      itemBuilder: (context, index) {
                        return _LibraryCard(component: dummyComponents[index]);
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Bottom Banner Simulasi
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2954E3),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [BoxShadow(color: const Color(0xFF2954E3).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.assignment, size: 12, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text('Ujian Lab TKJ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text('Mode Simulasi Bongkar-Pasang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2)),
                                const SizedBox(height: 8),
                                Text('Uji pemahaman orientasi soket dan urutan perakitan dalam kanvas 3D...', style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.8))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.play_arrow, color: Color(0xFF2954E3)),
                          )
                        ],
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
  final IconData icon;
  final bool isSelected;

  const _FilterChip({required this.label, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2954E3) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? const Color(0xFF2954E3) : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
        ],
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Explore3DScreen(initialComponent: component)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder area
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Icon(Icons.computer, size: 60, color: Colors.blueGrey[200]), // Dummy visual
                  ),
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: Text('Dasar', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                    ),
                  ),
                  Positioned(
                    top: 12, right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
                      child: const Icon(Icons.view_in_ar, size: 14, color: Color(0xFF2954E3)),
                    ),
                  ),
                ],
              ),
            ),
            // Details area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    component.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    component.shortDescription,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: Colors.teal[600]),
                          const SizedBox(width: 4),
                          Text('15 Mnt', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal[600])),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: const Color(0xFFE8EEFC), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward, size: 14, color: Color(0xFF2954E3)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
