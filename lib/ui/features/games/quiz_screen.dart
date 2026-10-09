import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/quiz_provider.dart';
import 'game_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selected;
  bool _submitted = false;
  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    if (question == null)
      return const Scaffold(body: Center(child: Text('Soal belum tersedia')));
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CompiHeader(
                  title: 'Component Challenge',
                  onBack: () => Navigator.pop(context),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.yellow, width: 3),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: AppColors.yellow,
                        size: 48,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quiz Challenge',
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Soal ${quiz.currentIndex + 1} dari ${quiz.totalQuestions}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${quiz.scorePoints} poin',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: quiz.progressPercentage,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.yellow,
                  backgroundColor: AppColors.primaryLight,
                ),
                const SizedBox(height: 16),
                CompiPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Pertanyaan ${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        question.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Pilih satu jawaban yang paling tepat.',
                        style: TextStyle(color: AppColors.textGray),
                      ),
                      const SizedBox(height: 14),
                      LayoutBuilder(
                        builder:
                            (context, constraints) => Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(question.options.length, (
                                i,
                              ) {
                                final selected = _selected == i;
                                final correct =
                                    _submitted &&
                                    i == question.correctAnswerIndex;
                                return SizedBox(
                                  width:
                                      constraints.maxWidth < 290
                                          ? constraints.maxWidth
                                          : (constraints.maxWidth - 10) / 2,
                                  child: InkWell(
                                    onTap:
                                        _submitted
                                            ? null
                                            : () =>
                                                setState(() => _selected = i),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        minHeight: 122,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color:
                                            correct
                                                ? const Color(0xFFD9FFE7)
                                                : selected
                                                ? AppColors.primaryLight
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                          color:
                                              correct
                                                  ? AppColors.success
                                                  : selected
                                                  ? AppColors.primary
                                                  : AppColors.border,
                                          width: 3,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColors.primary,
                                            child: Text(
                                              String.fromCharCode(65 + i),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            question.options[i],
                                            style: const TextStyle(
                                              color: AppColors.ink,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                      ),
                      if (_submitted)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            _selected == question.correctAnswerIndex
                                ? 'Benar! Jawabanmu tepat.'
                                : 'Jawaban yang benar: ${question.options[question.correctAnswerIndex]}',
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CompiButton(
                  label:
                      _submitted
                          ? (quiz.currentIndex + 1 == quiz.totalQuestions
                              ? 'Lihat Hasil'
                              : 'Soal Berikutnya')
                          : 'Kirim Jawaban',
                  icon: Icons.send,
                  onPressed:
                      _selected == null
                          ? null
                          : () {
                            if (!_submitted) {
                              quiz.answerQuestion(_selected!);
                              setState(() => _submitted = true);
                              return;
                            }
                            quiz.nextQuestion();
                            if (quiz.isFinished) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const GameResultScreen(),
                                ),
                              );
                            } else {
                              setState(() {
                                _selected = null;
                                _submitted = false;
                              });
                            }
                          },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
