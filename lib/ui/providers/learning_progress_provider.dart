import 'package:flutter/foundation.dart';
import '../../data/models/user_progress_model.dart';
import '../../data/repositories/progress_repository.dart';

/// Provider untuk mengelola progres belajar pengguna.
class LearningProgressProvider extends ChangeNotifier {
  final ProgressRepository _repository;
  UserProgressModel _progress = const UserProgressModel();

  LearningProgressProvider(this._repository) {
    _progress = _repository.readProgress();
  }

  Future<void> _pendingSave = Future.value();
  String? saveError;
  bool _disposed = false;
  Future<void> get settled => _pendingSave;
  Future<void> retrySave() => _saveProgress();

  /// Progres belajar saat ini.
  UserProgressModel get progress => _progress;

  /// Jumlah materi yang sudah diselesaikan.
  int get completedCount => _progress.completedMaterials.length;

  /// Skor kuis tertinggi.
  int get highestScore => _progress.highestQuizScore;

  /// Daftar badge yang sudah dibuka.
  List<String> get badges => _progress.unlockedBadges;

  Future<void> _saveProgress() async {
    final snapshot = _progress;
    _pendingSave = _pendingSave.then((_) async {
      try {
        await _repository.saveProgress(snapshot);
        saveError = null;
      } catch (_) {
        saveError = 'Progres belum tersimpan. Coba lagi.';
      }
      if (!_disposed) notifyListeners();
    });
    await _pendingSave;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Tandai sebuah materi sebagai selesai.
  void completeMaterial(String materialId) {
    if (_progress.completedMaterials.contains(materialId)) return;

    _progress = _progress.copyWith(
      completedMaterials: List<String>.from(_progress.completedMaterials)
        ..add(materialId),
    );
    _saveProgress();
    notifyListeners();
  }

  /// Cek apakah materi tertentu sudah selesai.
  bool isMaterialCompleted(String materialId) {
    return _progress.completedMaterials.contains(materialId);
  }

  /// Update skor kuis tertinggi jika skor baru lebih tinggi.
  void updateQuizScore(int score) {
    score = score.clamp(0, 100);
    if (score > _progress.highestQuizScore) {
      _progress = _progress.copyWith(highestQuizScore: score);
      _saveProgress();
      notifyListeners();
    }
  }

  /// Buka badge baru.
  void unlockBadge(String badge) {
    if (_progress.unlockedBadges.contains(badge)) return;

    _progress = _progress.copyWith(
      unlockedBadges: List<String>.from(_progress.unlockedBadges)..add(badge),
    );
    _saveProgress();
    notifyListeners();
  }

  /// Reset seluruh progres.
  void reset() {
    _progress = const UserProgressModel();
    _saveProgress();
    notifyListeners();
  }
}
