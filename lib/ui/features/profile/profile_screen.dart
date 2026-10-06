import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              // ── Header ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('COMPI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2954E3))),
                      Text('TKJ Hardware 3D', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Profile', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700])),
                      const SizedBox(width: 12),
                      const CircleAvatar(radius: 16, backgroundColor: Colors.black12, child: Icon(Icons.person, size: 18, color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Profile Card ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE8EEFC), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Color(0xFF2954E3), shape: BoxShape.circle),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, size: 40, color: Colors.blueGrey), // Dummy Avatar
                          ),
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const CircleAvatar(radius: 10, backgroundColor: Color(0xFF2954E3), child: Icon(Icons.check, size: 12, color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Anissa', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFFF0F4FA), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.school, size: 12, color: Colors.blue[800]),
                          const SizedBox(width: 6),
                          Text('Siswa TKJ - Kelas X • SMKN 1 Jakarta', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, size: 14, color: Color(0xFF2954E3)),
                          SizedBox(width: 6),
                          Text('Edit Profil', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Statistik Belajar ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.bar_chart, color: Color(0xFF2954E3), size: 20),
                      SizedBox(width: 8),
                      Text('Statistik Belajar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    ],
                  ),
                  Text('SEMESTER GANJIL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.menu_book, color: Color(0xFF2954E3), size: 16),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.lightBlue[50], borderRadius: BorderRadius.circular(8)),
                                child: Text('40%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('Total Materi', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                          const SizedBox(height: 4),
                          const Text('4 dari 10', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                          const SizedBox(height: 4),
                          Text('Selesai dipelajari', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(value: 0.4, backgroundColor: Colors.grey[200], color: const Color(0xFF2954E3), minHeight: 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.cyan[50], borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.emoji_events, color: Colors.teal, size: 16),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.cyan[50], borderRadius: BorderRadius.circular(8)),
                                child: const Text('Top 5', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('Rekor Skor Kuis', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                          const SizedBox(height: 4),
                          const Text('950 pts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                          const SizedBox(height: 4),
                          Text('Peringkat Sekolah', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 10, color: Colors.teal),
                              const SizedBox(width: 4),
                              Text('Tingkat SMKN 1', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal[700])),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ── Pencapaian Siswa ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pencapaian Siswa (3)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                  Text('Lihat Semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _AchievementCard(icon: Icons.military_tech, iconColor: Colors.amber, title: 'Pengenal CPU', status: 'Terbuka • Lv.1', statusColor: Colors.amber[700]!),
                    const SizedBox(width: 16),
                    _AchievementCard(icon: Icons.military_tech, iconColor: Colors.blueGrey, title: 'Pakar RAM', status: 'Terbuka • Lv.2', statusColor: const Color(0xFF2954E3)),
                    const SizedBox(width: 16),
                    _AchievementCard(icon: Icons.lock, iconColor: Colors.grey[300]!, title: 'Master GPU', status: 'Terkunci', statusColor: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Menu & Preferensi ──
              const Text('Menu & Preferensi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                child: Column(
                  children: [
                    _MenuRow(icon: Icons.manage_accounts, iconBg: const Color(0xFFE8EEFC), iconColor: const Color(0xFF2954E3), title: 'Pengaturan Akun', subtitle: 'Kata sandi, NISN & info data diri', trailingIcon: Icons.chevron_right),
                    const Divider(height: 1, indent: 64, endIndent: 20),
                    _MenuRow(icon: Icons.help_outline, iconBg: Colors.cyan[50]!, iconColor: Colors.teal, title: 'Pusat Bantuan & Tutorial', subtitle: 'Panduan interaksi 3D & FAQ COMPI', trailingIcon: Icons.chevron_right),
                    const Divider(height: 1, indent: 64, endIndent: 20),
                    _MenuRow(icon: Icons.workspace_premium, iconBg: const Color(0xFFE8EEFC), iconColor: const Color(0xFF2954E3), title: 'Unduh Sertifikat Kompetensi', subtitle: 'Akreditasi praktikum perakitan PC', trailingIcon: Icons.download),
                    const Divider(height: 1, indent: 64, endIndent: 20),
                    _MenuRow(
                      icon: Icons.logout, iconBg: Colors.red[50]!, iconColor: Colors.red, title: 'Keluar Akun', subtitle: 'Akhiri sesi perangkat ini', trailingIcon: Icons.arrow_forward, isDestructive: true,
                      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // ── Footer ──
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(radius: 3, backgroundColor: Colors.cyan),
                        const SizedBox(width: 6),
                        Text('COMPI TKJ 3D Simulator v2.4.1', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Laboratorium Jaringan & Komputer SMKN 1 Jakarta', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                    const SizedBox(height: 32), // Padding untuk navigation bar
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String status;
  final Color statusColor;

  const _AchievementCard({required this.icon, required this.iconColor, required this.title, required this.status, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    bool isLocked = status == 'Terkunci';
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isLocked ? const Color(0xFFF0F4FA) : Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [if (!isLocked) BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isLocked ? Colors.grey : const Color(0xFF1E293B)), maxLines: 1),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: isLocked ? Colors.grey[300] : statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLocked ? const SizedBox.shrink() : CircleAvatar(radius: 2, backgroundColor: statusColor),
                isLocked ? const SizedBox.shrink() : const SizedBox(width: 4),
                Text(status, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isLocked ? Colors.grey[600] : statusColor)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final IconData trailingIcon;
  final bool isDestructive;
  final VoidCallback? onTap;

  const _MenuRow({
    required this.icon, required this.iconBg, required this.iconColor, required this.title, required this.subtitle, required this.trailingIcon, this.isDestructive = false, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDestructive ? Colors.red : const Color(0xFF1E293B))),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                ],
              ),
            ),
            Icon(trailingIcon, size: 16, color: isDestructive ? Colors.red : Colors.grey),
          ],
        ),
      ),
    );
  }
}
