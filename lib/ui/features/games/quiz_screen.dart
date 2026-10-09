import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        if (provider.questions.isEmpty) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final question = provider.currentQuestion;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textDark), 
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Quiz', style: AppTypography.heading3.copyWith(fontSize: 18)),
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
                      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Icon(Icons.close, size: 12, color: AppColors.textGray),
                          const SizedBox(width: 4),
                          Text('Batal', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text('Skor: ${provider.score * 10}', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.cyan[100], borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 12, color: AppColors.textDark),
                              const SizedBox(width: 4),
                              Text('00:43', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark)),
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
                    Text('Pertanyaan ${provider.currentIndex + 1} dari ${provider.questions.length}', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    Text('TKJ Kelas X • Hardware Dasar', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (provider.currentIndex + 1) / provider.questions.length,
                    backgroundColor: AppColors.primaryLight,
                    color: AppColors.primary,
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
                            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                const CircleAvatar(radius: 3, backgroundColor: AppColors.primary),
                                const SizedBox(width: 6),
                                Text('SOAL #${provider.currentIndex + 1} • TINGKAT SEDANG', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                              ],
                            ),
                          ),
                          Icon(Icons.help_outline, color: Colors.lightBlue[300], size: 20),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        question?.question ?? '',
                        style: AppTypography.heading3.copyWith(fontSize: 18, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.touch_app, size: 14, color: Colors.teal),
                          const SizedBox(width: 6),
                          Text('Pilih salah satu jawaban di bawah ini:', style: AppTypography.caption.copyWith(color: AppColors.textGray)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Options Grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: List.generate(question?.options.length ?? 0, (index) {
                      final optionText = question!.options[index];
                      final isSelected = _selectedOption == index;
                      final letter = String.fromCharCode(65 + index); // A, B, C, D...
                      return _QuizOptionCard(
                        index: index,
                        letter: letter,
                        title: optionText,
                        isSelected: isSelected,
                        onTap: () => setState(() => _selectedOption = index),
                      );
                    }),
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
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('KIRIM JAWABAN', style: AppTypography.subtitle.copyWith(color: Colors.white, fontSize: 14)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
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
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizOptionCard({
    required this.index,
    required this.letter,
    required this.title,
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
              color: isSelected ? AppColors.primaryLight : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2),
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
                    child: Center(
                      child: Text(letter, style: AppTypography.heading1.copyWith(color: Colors.blueGrey[200])),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Text(
                    title, 
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.bold, 
                      color: isSelected ? AppColors.primary : AppColors.textDark
                    ), 
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          if (isSelected) 
            const Positioned(
              top: -5,
              right: -5,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
