import 'package:flutter/foundation.dart';
import '../../data/avatar_catalog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier {
  static const key = 'student_identity';
  final SharedPreferences _prefs;
  String _identity;
  static const avatarKey = 'student_avatar';
  String _avatarId = 'default';
  String get avatarId => _avatarId;

  StudentProvider(this._prefs) : _identity = _prefs.getString(key) ?? '' {
    final saved = _prefs.getString(avatarKey);
    _avatarId = findAvatar(saved)?.id ?? 'default';
  }

  Future<void> saveAvatar(String id) async {
    if (id != 'default' && findAvatar(id) == null) {
      throw ArgumentError('Avatar tidak tersedia');
    }
    if (!await _prefs.setString(avatarKey, id)) {
      throw StateError('Avatar gagal disimpan');
    }
    _avatarId = id;
    notifyListeners();
  }

  String get identity => _identity;
  bool get hasIdentity => _identity.trim().isNotEmpty;

  Future<void> logout() async {
    if (!await _prefs.remove(avatarKey)) {
      throw StateError('Avatar gagal dihapus');
    }
    await _prefs.remove('student_photo');
    _avatarId = 'default';
    if (!await _prefs.remove(key)) {
      throw StateError('Gagal keluar dari akun');
    }
    _identity = '';
    notifyListeners();
  }

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
