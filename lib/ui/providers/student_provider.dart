import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier {
  static const key = 'student_identity';
  final SharedPreferences _prefs;
  String _identity;

  StudentProvider(this._prefs) : _identity = _prefs.getString(key) ?? '';
  String get identity => _identity;
  bool get hasIdentity => _identity.trim().isNotEmpty;

  Future<void> save(String value) async {
    final next = value.trim();
    if (next.isEmpty) {
      return;
    }
    if (!await _prefs.setString(key, next)) {
      throw StateError('Identitas gagal disimpan');
    }
    _identity = next;
    notifyListeners();
  }
}
