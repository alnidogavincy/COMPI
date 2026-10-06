import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../providers/quiz_provider.dart';
import 'quiz_screen.dart';
import 'match_up_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

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
                      Text('Games Hub', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700])),
                      const SizedBox(width: 12),
                      const CircleAvatar(radius: 16, backgroundColor: Colors.black12, child: Icon(Icons.person, size: 18, color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Top Bar Poin ──
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.stars, color: Color(0xFF2954E3), size: 20),
                          const SizedBox(width: 8),
                          Text('Poin Kamu:', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          const Text('950 pts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2954E3))),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 30, color: Colors.grey[200]),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.emoji_events, color: Colors.cyan, size: 20),
                          const SizedBox(width: 8),
                          const Text('Top 5 SMK', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Judul ──
              Row(
                children: [
                  const Icon(Icons.sports_esports, color: Color(0xFF2954E3), size: 24),
                  const SizedBox(width: 8),
                  const Text('Pilih Mode Tantangan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Uji keahlian perakitan dan pemahaman hardware kamu lewat game interaktif!',
                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
              ),
              const SizedBox(height: 24),

              // ── Kuis Pilihan Ganda ──
              _GameModeCard(
                title: 'Component Challenge',
                badgeText: 'Kuis Pilihan Ganda',
                badgeColor: const Color(0xFFE8EEFC),
                badgeTextColor: const Color(0xFF2954E3),
                statsText: '10 Soal',
                description: 'Jawab kuis pilihan ganda tentang fungsi, arsitektur, dan deskripsi teknis...',
                features: const ['+150 XP per sesi', 'Soal Acak TKJ'],
                buttonText: 'Mulai Kuis',
                buttonIcon: Icons.bolt,
                onTap: () {
                  context.read<QuizProvider>().loadQuiz(dummyQuizQuestions);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                },
              ),
              const SizedBox(height: 20),

              // ── Match Up Game ──
              _GameModeCard(
                title: 'Match Up / Assemble',
                badgeText: 'Game Pasang Komponen',
                badgeColor: Colors.cyan[50]!,
                badgeTextColor: Colors.cyan[800]!,
                statsText: '3 Level',
                description: 'Cocokkan gambar komponen hardware di sisi kiri dengan nama atau fungsi soket.',
                features: const ['Drag & Drop Interaktif', 'Inspeksi Pin 3D'],
                buttonText: 'Mulai Match Up',
                buttonIcon: Icons.extension,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MatchUpScreen()));
                },
              ),
              const SizedBox(height: 32),

              // ── Leaderboard ──
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                            SizedBox(width: 8),
                            Text('Papan Skor Mingguan\nSMK TKJ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                          ],
                        ),
                        Text('Lihat\nSemua >', textAlign: TextAlign.right, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Top 3 Players
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _LeaderboardAvatar(name: 'Fahri R.', school: 'SMKN 1 Bdg', points: '1.240 pts', rank: 2, height: 110),
                        const SizedBox(width: 12),
                        _LeaderboardAvatar(name: 'Naila S.', school: 'SMKN 2 Jkt', points: '1.480 pts', rank: 1, height: 130, isFirst: true),
                        const SizedBox(width: 12),
                        _LeaderboardAvatar(name: 'Dimas A.', school: 'SMK Telkom', points: '1.110 pts', rank: 3, height: 100),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Streak Notification
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFF0F4FA), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb_outline, size: 20, color: Color(0xFF2954E3)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                children: const [
                                  TextSpan(text: 'Mainkan 1 sesi tantangan hari ini untuk mempertahankan status '),
                                  TextSpan(text: 'Streak 4 Hari', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                                  TextSpan(text: ' kamu!'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

class _GameModeCard extends StatelessWidget {
  final String title;
  final String badgeText;
  final Color badgeColor;
  final Color badgeTextColor;
  final String statsText;
  final String description;
  final List<String> features;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onTap;

  const _GameModeCard({
    required this.title,
    required this.badgeText,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.statsText,
    required this.description,
    required this.features,
    required this.buttonText,
    required this.buttonIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70, height: 70,
                decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(16)),
                child: Icon(buttonIcon, size: 30, color: Colors.blueGrey[300]), // Image placeholder
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(8)),
                          child: Text(badgeText, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: badgeTextColor)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Icon(Icons.timer, size: 10, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(statsText, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    const SizedBox(height: 4),
                    Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: features.map((f) => Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 12, color: const Color(0xFF2954E3)),
                    const SizedBox(width: 4),
                    Text(f, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                  ],
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(buttonIcon, size: 18, color: Colors.white),
              label: Text(buttonText, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2954E3),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LeaderboardAvatar extends StatelessWidget {
  final String name;
  final String school;
  final String points;
  final int rank;
  final double height;
  final bool isFirst;

  const _LeaderboardAvatar({
    required this.name,
    required this.school,
    required this.points,
    required this.rank,
    required this.height,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: height,
      decoration: BoxDecoration(
        color: isFirst ? const Color(0xFFE8EEFC) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey[100],
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: 16, height: 16,
                  decoration: BoxDecoration(
                    color: isFirst ? Colors.amber : Colors.blueGrey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text('$rank', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)), maxLines: 1),
          Text(school, style: TextStyle(fontSize: 9, color: Colors.grey[600]), maxLines: 1),
          const SizedBox(height: 4),
          Text(points, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: const Color(0xFF2954E3))),
        ],
      ),
    );
  }
}
