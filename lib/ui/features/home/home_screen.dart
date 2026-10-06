import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/quiz_provider.dart';
import '../../../data/dummy_data.dart';
import '../explore_3d/explore_3d_screen.dart';
import '../games/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header APP ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'COMPI',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2954E3)),
                      ),
                      const SizedBox(width: 8),
                      Text('Home', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person, size: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Profil Pengguna ──
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, size: 30, color: Colors.white), // Placeholder Avatar
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 14, height: 14,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Halo, Vina 👋',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                        ),
                        Text(
                          'Siap belajar hari ini?',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EEFC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Color(0xFF2954E3)),
                        const SizedBox(width: 4),
                        Text('27 Agu 2026', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: const Stack(
                      children: [
                        Icon(Icons.notifications_none, size: 20),
                        Positioned(
                          right: 0, top: 0,
                          child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Kata Hari Ini ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEFC),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lightbulb, size: 14, color: Color(0xFF2954E3)),
                                SizedBox(width: 4),
                                Text('KATA HARI INI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '"Komputer hari ini, Komputer hebat di masa depan"',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), height: 1.3),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Semangat SMK TKJ Hebat!',
                            style: TextStyle(fontSize: 12, color: Colors.blue[800], fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 70, height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6E4FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.laptop_chromebook, size: 40, color: Color(0xFF2954E3)),
                          Positioned(
                            top: -5, right: -5,
                            child: CircleAvatar(
                              radius: 10, backgroundColor: Colors.lightBlue,
                              child: Icon(Icons.bolt, size: 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Progres Belajar ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Progres Belajar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EEFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('TKJ Kelas X', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF2954E3), shape: BoxShape.circle)),
                              const SizedBox(width: 6),
                              const Text('MODUL SEDANG AKTIF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('Penyimpanan Data (SSD/HDD)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('4 dari 10 Materi Selesai', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: Colors.teal[600]),
                              const SizedBox(width: 4),
                              Text('Estimasi 15 menit lagi', style: TextStyle(fontSize: 12, color: Colors.teal[600], fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70, height: 70,
                          child: CircularProgressIndicator(
                            value: 0.4,
                            strokeWidth: 8,
                            backgroundColor: const Color(0xFFE8EEFC),
                            color: const Color(0xFF2954E3),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('40%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2954E3))),
                            Text('Selesai', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Akses Cepat Praktik ──
              const Text('Akses Cepat Praktik', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _QuickAccessCard(
                      title: 'Explore',
                      subtitle: 'SIMULATOR INTERAKTIF',
                      icon: Icons.view_in_ar,
                      color: const Color(0xFF2954E3),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Explore3DScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _QuickAccessCard(
                      title: 'Tantangan',
                      subtitle: 'UJI KOMPETENSI',
                      icon: Icons.sports_esports,
                      color: const Color(0xFFE8EEFC),
                      textColor: const Color(0xFF1E293B),
                      onTap: () {
                        context.read<QuizProvider>().loadQuiz(dummyQuizQuestions);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ── Lanjutkan Belajar ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Lanjutkan Belajar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  Text('Lihat Semua >', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _ContinueLearningCard(
                      title: 'Motherboard',
                      subtitle: 'Arsitektur PCB',
                      description: 'Form factor ATX & Chipset',
                      icon: Icons.developer_board,
                      progress: 1.0, // Selesai
                    ),
                    const SizedBox(width: 16),
                    _ContinueLearningCard(
                      title: 'Processor (CPU)',
                      subtitle: 'Unit Pemrosesan',
                      description: 'Inti pemrosesan komputer',
                      icon: Icons.memory,
                      progress: 0.65,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: textColor == Colors.white ? Colors.white.withOpacity(0.2) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: textColor == Colors.white ? Colors.white : const Color(0xFF2954E3), size: 24),
                ),
                Icon(Icons.arrow_forward, color: textColor.withOpacity(0.7), size: 20),
              ],
            ),
            const SizedBox(height: 24),
            Text(subtitle, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor.withOpacity(0.8))),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: textColor)),
          ],
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final double progress;

  const _ContinueLearningCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress >= 1.0;
    
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF2954E3), size: 20),
              ),
              isCompleted
                ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF2954E3)),
                      const SizedBox(width: 4),
                      Text('Selesai', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${(progress * 100).toInt()}% Progress', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal[700])),
                ),
            ],
          ),
          const Spacer(),
          Text(subtitle, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 16),
          !isCompleted ? const SizedBox.shrink() : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Review 3D', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8EEFC),
                  foregroundColor: const Color(0xFF1E293B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          isCompleted ? const SizedBox.shrink() : ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: const Color(0xFF2954E3),
                minHeight: 6,
              ),
            ),
          isCompleted ? const SizedBox.shrink() : const SizedBox(height: 8),
          isCompleted ? const SizedBox.shrink() : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow, size: 16, color: Colors.white),
                label: const Text('Lanjutkan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2954E3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
