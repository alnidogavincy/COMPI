import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_progress_model.dart';

class ProgressRepository {
  static const String _progressKey = 'user_progress';
  final SharedPreferences _prefs;

  ProgressRepository(this._prefs);
  SharedPreferences get preferences => _prefs;

  Future<UserProgressModel> getProgress() async {
    final String? progressJson = _prefs.getString(_progressKey);
    if (progressJson != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(progressJson);
        return UserProgressModel.fromJson(data);
      } catch (e) {
        // Fallback on error
        return const UserProgressModel();
      }
    }
    return const UserProgressModel();
  }

  Future<void> saveProgress(UserProgressModel progress) async {
    final String progressJson = jsonEncode(progress.toJson());
    await _prefs.setString(_progressKey, progressJson);
  }
}
