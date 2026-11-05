import 'package:compi/data/dummy_data.dart';
import 'package:compi/ui/features/games/quiz_instructions_screen.dart';
import 'package:compi/ui/features/games/quiz_screen.dart';
import 'package:compi/ui/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('petunjuk muncul sebelum timer latihan dimulai', (tester) async {
    final quiz = QuizProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: quiz,
        child: const MaterialApp(home: QuizInstructionsScreen()),
      ),
    );

    expect(find.text('Siap-siap, ada batas waktu!'), findsOneWidget);
    expect(find.text('10 detik untuk setiap soal'), findsOneWidget);
    expect(find.text('Waktu habis? Otomatis lanjut'), findsOneWidget);
    expect(quiz.totalQuestions, 0);

    await tester.ensureVisible(find.text('Saya Mengerti, Mulai Latihan'));
    await tester.tap(find.text('Saya Mengerti, Mulai Latihan'));
    await tester.pumpAndSettle();

    expect(find.byType(QuizScreen), findsOneWidget);
    expect(quiz.totalQuestions, greaterThan(0));
    expect(find.text('00:10'), findsOneWidget);
  });

  testWidgets('waktu habis otomatis lanjut dan mengatur timer soal baru', (
    tester,
  ) async {
    final quiz = QuizProvider()..loadQuiz(dummyQuizQuestions.take(2).toList());

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: quiz,
        child: const MaterialApp(home: QuizScreen()),
      ),
    );

    expect(find.text('00:10'), findsOneWidget);

    await tester.pump(const Duration(seconds: 10));

    expect(quiz.score, 0);
    expect(quiz.currentIndex, 1);
    expect(quiz.selectedAnswer, isNull);
    expect(find.text('00:10'), findsOneWidget);
  });
}
