import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import 'game_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedOption = -1;

  @override
  void initState() {
    super.initState();
    // Memaksa mode Portrait untuk kuis (karena sebelumnya landscape)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Mengembalikan ke mode rotasi bebas saat keluar
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
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        if (provider.questions.isEmpty) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final question = provider.currentQuestion;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
            title: const Text('Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(radius: 14, backgroundColor: Colors.black12, child: Icon(Icons.person, size: 16, color: Colors.white)),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Status Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Icon(Icons.close, size: 12, color: Colors.grey[700]),
                          const SizedBox(width: 4),
                          Text('Batal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: Color(0xFF2954E3)),
                              const SizedBox(width: 4),
                              Text('Skor: ${provider.score * 10}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.cyan[100], borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 12, color: Color(0xFF1E293B)),
                              SizedBox(width: 4),
                              Text('00:43', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),

                // Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pertanyaan ${provider.currentIndex + 1} dari ${provider.questions.length}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                    Text('TKJ Kelas X • Hardware Dasar', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[500])),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (provider.currentIndex + 1) / provider.questions.length,
                    backgroundColor: const Color(0xFFE8EEFC),
                    color: const Color(0xFF2954E3),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 24),

                // Question Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(12)),
                            child: const Row(
                              children: [
                                CircleAvatar(radius: 3, backgroundColor: Color(0xFF2954E3)),
                                SizedBox(width: 6),
                                Text('SOAL #1 • TINGKAT SEDANG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                              ],
                            ),
                          ),
                          Icon(Icons.help_outline, color: Colors.lightBlue[300], size: 20),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        question?.question ?? '',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.touch_app, size: 14, color: Colors.teal),
                          const SizedBox(width: 6),
                          Text('Pilih salah satu kartu komponen 3D di bawah ini:', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Options Grid (Custom Visuals for mockup)
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: [
                      _QuizOptionCard(
                        index: 0,
                        letter: 'A',
                        title: 'RAM (Memory)',
                        subtitle: 'Memori Sementara',
                        isSelected: _selectedOption == 0,
                        onTap: () => setState(() => _selectedOption = 0),
                      ),
                      _QuizOptionCard(
                        index: 1,
                        letter: 'B',
                        title: 'CPU / Processor',
                        subtitle: 'Central Processing',
                        isSelected: _selectedOption == 1,
                        onTap: () => setState(() => _selectedOption = 1),
                      ),
                      _QuizOptionCard(
                        index: 2,
                        letter: 'C',
                        title: 'VGA / GPU Card',
                        subtitle: 'Pemroses Grafis',
                        isSelected: _selectedOption == 2,
                        onTap: () => setState(() => _selectedOption = 2),
                      ),
                      _QuizOptionCard(
                        index: 3,
                        letter: 'D',
                        title: 'Power Supply',
                        subtitle: 'Catu Daya Utama',
                        isSelected: _selectedOption == 3,
                        onTap: () => setState(() => _selectedOption = 3),
                      ),
                    ],
                  ),
                ),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedOption == -1
                        ? null
                        : () {
                            provider.answerQuestion(_selectedOption);
                            setState(() => _selectedOption = -1);

                            if (provider.isFinished) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const GameResultScreen()),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2954E3),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('KIRIM JAWABAN', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuizOptionCard extends StatelessWidget {
  final int index;
  final String letter;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizOptionCard({
    required this.index,
    required this.letter,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE8EEFC) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? const Color(0xFF2954E3) : Colors.transparent, width: 2),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Icon(Icons.memory, size: 40, color: Colors.blueGrey[200])), // Placeholder image
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                  child: Column(
                    children: [
                      Text('$letter. $title', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? const Color(0xFF2954E3) : const Color(0xFF1E293B)), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(subtitle, style: TextStyle(fontSize: 10, color: isSelected ? const Color(0xFF2954E3).withOpacity(0.8) : Colors.grey[600]), maxLines: 1),
                    ],
                  ),
                )
              ],
            ),
          ),
          !isSelected ? const SizedBox.shrink() : const Positioned(
              top: -5,
              right: -5,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xFF2954E3),
                child: Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
