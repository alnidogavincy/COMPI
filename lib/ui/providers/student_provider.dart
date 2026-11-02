import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier {
  static const key = 'student_identity';
  final SharedPreferences _prefs;
  String _identity;
  static const photoKey = 'student_photo';
  Uint8List? _photo;
  Uint8List? get photo => _photo;

  StudentProvider(this._prefs) : _identity = _prefs.getString(key) ?? '' {
    try {
      final saved = _prefs.getString(photoKey);
      if (saved != null) _photo = base64Decode(saved);
    } on FormatException {
      _photo = null;
    }
  }

  Future<void> savePhoto(Uint8List? bytes) async {
    if (bytes != null && bytes.length > 1024 * 1024) {
      throw ArgumentError('Foto terlalu besar');
    }
    final saved =
        bytes == null
            ? await _prefs.remove(photoKey)
            : await _prefs.setString(photoKey, base64Encode(bytes));
    if (!saved) throw StateError('Foto gagal disimpan');
    _photo = bytes;
    notifyListeners();
  }

  String get identity => _identity;
  bool get hasIdentity => _identity.trim().isNotEmpty;

  Future<void> logout() async {
    await savePhoto(null);
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
