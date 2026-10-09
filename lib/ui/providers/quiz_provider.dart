import 'package:flutter/foundation.dart';
import '../../data/models/quiz_question_model.dart';

/// Provider untuk mengelola state kuis.
class QuizProvider extends ChangeNotifier {
  List<QuizQuestionModel> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _isFinished = false;
  bool _isMatchResult = false;
  int _matchCorrect = 0;
  int _matchTotal = 0;
  bool get isMatchResult => _isMatchResult;
  int get correctCount => _isMatchResult ? _matchCorrect : _score;
  int get resultTotal => _isMatchResult ? _matchTotal : _questions.length;
  int get scorePoints =>
      resultTotal == 0 ? 0 : (correctCount * 100 ~/ resultTotal);

  void loadMatchResult(int correct, int total) {
    _isMatchResult = true;
    _matchCorrect = correct;
    _matchTotal = total;
    _isFinished = true;
    notifyListeners();
  }

  /// Daftar soal kuis.
  List<QuizQuestionModel> get questions => _questions;

  /// Indeks soal saat ini.
  int get currentIndex => _currentIndex;

  /// Soal yang sedang ditampilkan.
  QuizQuestionModel? get currentQuestion =>
      _questions.isNotEmpty && _currentIndex < _questions.length
          ? _questions[_currentIndex]
          : null;

  /// Skor saat ini.
  int get score => _score;

  /// Jawaban yang dipilih pada soal saat ini.
  int? get selectedAnswer => _selectedAnswer;

  /// Apakah kuis sudah selesai.
  bool get isFinished => _isFinished;

  /// Total soal.
  int get totalQuestions => _questions.length;

  /// Persentase progres kuis (0.0 - 1.0).
  double get progressPercentage =>
      _questions.isEmpty ? 0.0 : (_currentIndex + 1) / _questions.length;

  /// Muat soal kuis berdasarkan componentId, atau semua soal jika null.
  void loadQuiz(List<QuizQuestionModel> allQuestions, {String? componentId}) {
    _isMatchResult = false;
    if (componentId != null) {
      _questions =
          allQuestions.where((q) => q.componentId == componentId).toList();
    } else {
      _questions = List.from(allQuestions);
    }
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;
    _isFinished = false;
    notifyListeners();
  }

  /// Jawab soal saat ini.
  void answerQuestion(int answerIndex) {
    if (_isFinished || currentQuestion == null || _selectedAnswer != null) {
      return;
    }

    _selectedAnswer = answerIndex;
    if (answerIndex == currentQuestion!.correctAnswerIndex) {
      _score++;
    }
    notifyListeners();
  }

  /// Pindah ke soal berikutnya.
  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _selectedAnswer = null;
      notifyListeners();
    } else {
      _isFinished = true;
      notifyListeners();
    }
  }

  /// Reset kuis ke awal.
  void resetQuiz() {
    _isMatchResult = false;
    _matchCorrect = 0;
    _matchTotal = 0;
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;
    _isFinished = false;
    notifyListeners();
  }
}
