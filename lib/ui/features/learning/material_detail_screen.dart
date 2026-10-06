import 'package:flutter/material.dart';
import '../../../data/models/component_model.dart';
import '../../../data/models/learning_material_model.dart';
import 'package:provider/provider.dart';
import '../../providers/learning_progress_provider.dart';

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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Materi', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF2954E3), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text('Materi 3 dari 8', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF2954E3))),
                    const SizedBox(width: 8),
                    Text('• Perangkat Keras Utama', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
                Text('35% selesai', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800])),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: 0.35, backgroundColor: Colors.grey[200], color: const Color(0xFF2954E3), minHeight: 4),
            ),
            const SizedBox(height: 24),

            // Audio Player (Dummy)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[200]!)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.volume_up, color: Color(0xFF2954E3), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Audio Narasi Pembelajaran', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                        Text('02:14 • Narator COMPI AI', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark_border, color: Colors.grey, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Image Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFE8EEFC), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2954E3).withOpacity(0.2))),
                        child: const Row(
                          children: [
                            Icon(Icons.memory, size: 12, color: Color(0xFF2954E3)),
                            SizedBox(width: 4),
                            Text('Penyimpanan Primer (Volatile)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.lightBlue[100], borderRadius: BorderRadius.circular(12)),
                        child: Text('DDR5 SDRAM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[900])),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Icon(Icons.memory, size: 80, color: Color(0xFF2954E3)), // Dummy Image
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.threed_rotation, size: 12, color: Color(0xFF2954E3)),
                          SizedBox(width: 4),
                          Text('Ketuk untuk Inspeksi 3D', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Specs Row
            component.specs == null ? const SizedBox.shrink() : Column(
                children: [
                  Row(
                    children: component.specs!.entries.map((entry) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey[200]!)),
                          child: Column(
                            children: [
                              Text(entry.key, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[500])),
                              const SizedBox(height: 4),
                              Text(entry.value.split(' ').first, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2954E3))),
                              Text(entry.value.split(' ').length > 1 ? entry.value.split(' ').last : '', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),

            // Text Content Section
            Row(
              children: [
                Container(width: 4, height: 16, decoration: BoxDecoration(color: const Color(0xFF2954E3), borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 8),
                const Text('Pengertian & Fungsi Dasar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
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
                      style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.6),
                      children: [
                        TextSpan(text: component.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                        TextSpan(text: ' adalah ${component.shortDescription.toLowerCase()} '),
                        TextSpan(text: component.fullDescription),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF0F4FA), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, size: 18, color: Color(0xFF2954E3)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Begitu komputer dimatikan atau kehilangan suplai daya, seluruh data di dalamnya akan terhapus secara otomatis karena sifatnya yang volatile.',
                            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Karakteristik Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 4, height: 16, decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 8),
                    const Text('Karakteristik Utama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                  ],
                ),
                Text('TEKNIK TKJ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[500])),
              ],
            ),
            const SizedBox(height: 16),
            _KarakteristikCard(icon: Icons.bolt, iconColor: Colors.redAccent, title: 'Volatilitas Data Real-Time', desc: 'Hanya dapat menyimpan instruksi selama ada pasokan arus listrik.'),
            const SizedBox(height: 12),
            _KarakteristikCard(icon: Icons.speed, iconColor: const Color(0xFF2954E3), title: 'Kecepatan Akses Bus Langsung', desc: 'Terhubung langsung dengan prosesor melalui jalur Memory Controller Bus.'),
            const SizedBox(height: 12),
            _KarakteristikCard(icon: Icons.view_column, iconColor: Colors.teal, title: 'Slot DIMM & Konfigurasi', desc: 'Dipasang secara vertikal pada slot DIMM motherboard dengan pengunci klip.'),
            
            const SizedBox(height: 32),
            
            // Bottom Action
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF2954E3), borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.psychology, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text('UJI PEMAHAMAN CEPAT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Jika sebuah PC laboratorium mengalami layar hitam dan terdengar bunyi beep 3 kali pendek, kemungkinan besar karena...', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9))),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<LearningProgressProvider>().completeMaterial(material.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check_circle_outline, color: Color(0xFF2954E3)),
                      label: const Text('Tandai Selesai Dibaca', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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

class _KarakteristikCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String desc;

  const _KarakteristikCard({required this.icon, required this.iconColor, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey[100]!)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
