import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';

class GameResultScreen extends StatefulWidget {
  const GameResultScreen({super.key});

  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.read<QuizProvider>();
    final score = quizProvider.score * 10;
    
    // Asumsi 10 soal, jika tidak maka menyesuaikan
    final totalSoal = quizProvider.questions.isEmpty ? 10 : quizProvider.questions.length;
    final accuracy = "${quizProvider.score}/$totalSoal";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Game Result', style: TextStyle(fontWeight: FontWeight.bold)),
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
          children: [
            // Container Utama
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
              ),
              child: Column(
                children: [
                  // Image Piala
                  Container(
                    height: 140, width: 140,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.emoji_events, size: 80, color: Colors.amber[400]),
                        Positioned(
                          top: -5, right: -5,
                          child: CircleAvatar(radius: 12, backgroundColor: Colors.lightBlue, child: Icon(Icons.star, size: 14, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Label & Judul
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(16)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, size: 14, color: Color(0xFF2954E3)),
                        SizedBox(width: 6),
                        Text('SIMULASI PERAKITAN SELESAI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3), letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Tantangan Selesai!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                  const SizedBox(height: 8),
                  Text('Luar biasa! Pemahaman perangkat keras komputer kamu sangat mantap.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4)),
                  const SizedBox(height: 32),
                  
                  // Statistik Row
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(label: 'Skor Akhir', value: '$score', suffix: '/100', icon: null),
                        Container(width: 1, height: 40, color: Colors.grey[300]),
                        _StatItem(label: 'Waktu', value: '02:15', suffix: '', icon: Icons.timer_outlined),
                        Container(width: 1, height: 40, color: Colors.grey[300]),
                        _StatItem(label: 'Akurasi', value: accuracy, suffix: '', icon: Icons.check_circle_outline, iconColor: Colors.teal),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Pencapaian Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.lightBlue[100], borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.military_tech, color: Color(0xFF2954E3), size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text('PENCAPAIAN BARU ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                                  Text('🥇', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text('Hardware Master TKJ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                              const SizedBox(height: 4),
                              Text('Berhasil mendiagnosis socket CPU, RAM dual-channel, & kartu PCI...', style: TextStyle(fontSize: 11, color: Colors.blue[900], height: 1.4)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Tips Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFF0F4FA), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline, size: 20, color: Color(0xFF2954E3)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 11, color: Colors.grey[700], height: 1.4),
                              children: const [
                                TextSpan(text: 'Sedikit lagi sempurna! Ulangi modul '),
                                TextSpan(text: 'Front Panel I/O', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                                TextSpan(text: ' untuk skor 100%.'),
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
            const SizedBox(height: 32),
            
            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
                label: const Text('Main Lagi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2954E3),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.home_outlined, color: Color(0xFF2954E3), size: 20),
                label: const Text('Kembali ke Menu Utama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.transparent), // Kita pakai background putih biasa aja untuk outline
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String suffix;
  final IconData? icon;
  final Color? iconColor;

  const _StatItem({required this.label, required this.value, required this.suffix, this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            icon == null ? const SizedBox.shrink() : Icon(icon, size: 14, color: iconColor ?? const Color(0xFF1E293B)),
            icon == null ? const SizedBox.shrink() : const SizedBox(width: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: iconColor ?? const Color(0xFF2954E3))),
            suffix.isEmpty ? const SizedBox.shrink() : Text(suffix, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[500])),
          ],
        )
      ],
    );
  }
}
