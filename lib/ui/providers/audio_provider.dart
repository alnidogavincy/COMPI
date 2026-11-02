import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Two reusable players: streaming music and one short effect at a time.
class AudioProvider extends ChangeNotifier with WidgetsBindingObserver {
  AudioProvider(this._prefs, {AudioOutput? output})
    : _output = output ?? PlayerAudioOutput(),
      enabled = _prefs.getBool(key) ?? true {
    WidgetsBinding.instance.addObserver(this);
  }
  static const key = 'sound_enabled';
  final SharedPreferences _prefs;
  bool enabled;
  bool _activated = false, _foreground = true, _disposed = false;
  final AudioOutput _output;
  Future<void> get settled =>
      Future.wait([_musicQueue, _effectQueue]).then((_) {});
  Future<void> _musicQueue = Future.value();
  Future<void> _effectQueue = Future.value();
  DateTime _lastEffect = DateTime(2000);
  int _effectRevision = 0;
  String? error;

  // Called from a real interaction, so browsers can allow playback.
  void activate() {
    if (_activated || !enabled) return;
    _activated = true;
    _syncMusic();
  }

  Future<void> toggle() async {
    final next = !enabled;
    if (!await _prefs.setBool(key, next)) return;
    if (_disposed) return;
    enabled = next;
    _activated = true;
    error = null;
    notifyListeners();
    _effectRevision++;
    _effectQueue = _effectQueue
        .then((_) async {
          if (!enabled) await _output.stopEffect();
        })
        .catchError((Object _) {});
    _syncMusic();
  }

  void _syncMusic() {
    _musicQueue = _musicQueue
        .then((_) async {
          if (_disposed) return;
          if (!enabled || !_activated || !_foreground) {
            await _output.pauseMusic();
            return;
          }
          await _output.resumeMusic();
          if (!enabled || !_foreground || _disposed) await _output.pauseMusic();
        })
        .catchError((Object _) {
          if (_disposed) return;
          error =
              'Audio belum dapat diputar. Coba matikan lalu nyalakan suara.';
          notifyListeners();
        });
  }

  void effect(String name) {
    if (!enabled || !_foreground || _disposed) return;
    activate();
    final now = DateTime.now();
    if (name == 'puck' && now.difference(_lastEffect).inMilliseconds < 100) {
      return;
    }
    _lastEffect = now;
    final revision = ++_effectRevision;
    _effectQueue = _effectQueue
        .then((_) async {
          if (_disposed ||
              !enabled ||
              !_foreground ||
              revision != _effectRevision) {
            return;
          }
          await _output.stopEffect();
          if (_disposed || !enabled || revision != _effectRevision) return;
          await _output.playEffect(name);
        })
        .catchError((Object _) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    if (!_foreground) {
      _effectRevision++;
      _effectQueue = _effectQueue
          .then((_) async {
            await _output.stopEffect();
          })
          .catchError((Object _) {});
    }
    _syncMusic();
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    unawaited(settled.then((_) => _output.dispose()).catchError((Object _) {}));
    super.dispose();
  }
}

abstract interface class AudioOutput {
  Future<void> resumeMusic();
  Future<void> pauseMusic();
  Future<void> playEffect(String name);
  Future<void> stopEffect();
  Future<void> dispose();
}

class PlayerAudioOutput implements AudioOutput {
  AudioPlayer? _music, _effects;
  bool _musicReady = false;
  @override
  Future<void> resumeMusic() async {
    _music ??= AudioPlayer();
    if (!_musicReady) {
      await _music!.setReleaseMode(ReleaseMode.loop);
      await _music!.setVolume(.16);
      await _music!.setSource(AssetSource('audio/hackbeat.mp3'));
      _musicReady = true;
    }
    await _music!.resume();
  }

  @override
  Future<void> pauseMusic() async {
    await _music?.pause();
  }

  @override
  Future<void> playEffect(String name) async {
    _effects ??= AudioPlayer();
    await _effects!.play(AssetSource('audio/$name.mp3'), volume: .38);
  }

  @override
  Future<void> stopEffect() async {
    await _effects?.stop();
  }

  @override
  Future<void> dispose() async {
    await _music?.dispose();
    await _effects?.dispose();
  }
}
