import 'package:compi/data/models/user_progress_model.dart';
import 'package:compi/data/repositories/progress_repository.dart';
import 'package:compi/data/dummy_data.dart';
import 'package:compi/ui/providers/quiz_provider.dart';
import 'package:compi/ui/providers/student_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('identitas baru tidak mengubah progres lama', () async {
    SharedPreferences.setMockInitialValues({
      'user_progress':
          '{"completedMaterials":["mat_ram_01"],"highestQuizScore":75,"unlockedBadges":[]}',
    });
    final prefs = await SharedPreferences.getInstance();
    final student = StudentProvider(prefs);
    await student.save(' Vika (TKJ) ');
    expect(student.identity, 'Vika (TKJ)');
    expect(prefs.getString(StudentProvider.key), 'Vika (TKJ)');
    final progress = await ProgressRepository(prefs).getProgress();
    expect(progress.completedMaterials, contains('mat_ram_01'));
    expect(progress.highestQuizScore, 75);
    expect(UserProgressModel.fromJson(progress.toJson()).highestQuizScore, 75);
  });

  test('hasil Match dan kuis menghitung skor dari jumlah soal nyata', () {
    final quiz = QuizProvider();
    quiz.loadMatchResult(3, 4);
    expect(quiz.scorePoints, 75);
    expect(quiz.correctCount, 3);
    quiz.loadQuiz(dummyQuizQuestions.take(2).toList());
    expect(quiz.isMatchResult, false);
    expect(quiz.resultTotal, 2);
    quiz.answerQuestion(quiz.currentQuestion!.correctAnswerIndex);
    quiz.answerQuestion(quiz.currentQuestion!.correctAnswerIndex);
    expect(quiz.scorePoints, 50);
  });
}
