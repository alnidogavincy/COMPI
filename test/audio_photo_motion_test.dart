import 'dart:ui' as ui;
import 'package:compi/ui/core/physical_button.dart';
import 'package:compi/ui/providers/audio_provider.dart';
import 'package:compi/ui/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeOutput implements AudioOutput {
  bool music = false;
  final effects = <String>[];
  int stops = 0;
  @override
  Future<void> resumeMusic() async {
    music = true;
  }

  @override
  Future<void> pauseMusic() async {
    music = false;
  }

  @override
  Future<void> playEffect(String name) async {
    effects.add(name);
  }

  @override
  Future<void> stopEffect() async {
    stops++;
  }

  @override
  Future<void> dispose() async {
    music = false;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('sound preference persists, mute and background stop audio', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final output = FakeOutput();
    final audio = AudioProvider(prefs, output: output);
    audio.activate();
    await audio.settled;
    expect(output.music, isTrue);
    audio.effect('star');
    await audio.settled;
    expect(output.effects, ['star']);
    await audio.toggle();
    await audio.settled;
    expect(output.music, isFalse);
    audio.effect('win');
    await audio.settled;
    expect(output.effects, ['star']);
    final reloaded = AudioProvider(prefs, output: FakeOutput());
    expect(reloaded.enabled, isFalse);
    reloaded.dispose();
    await audio.toggle();
    await audio.settled;
    audio.didChangeAppLifecycleState(AppLifecycleState.paused);
    await audio.settled;
    expect(output.music, isFalse);
    audio.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await audio.settled;
    expect(output.music, isTrue);
    audio.dispose();
  });

  test('avatar persists and logout preserves learning progress', () async {
    SharedPreferences.setMockInitialValues({
      'user_progress': 'keep',
      'student_photo': 'legacy',
    });
    final prefs = await SharedPreferences.getInstance();
    final student = StudentProvider(prefs);
    await student.save('Vika');
    await student.saveAvatar('avatar_2');
    expect(StudentProvider(prefs).avatarId, 'avatar_2');
    await expectLater(student.saveAvatar('unknown'), throwsArgumentError);
    expect(student.avatarId, 'avatar_2');
    await student.logout();
    expect(StudentProvider(prefs).avatarId, 'default');
    expect(prefs.containsKey('student_photo'), isFalse);
    expect(prefs.getString('user_progress'), 'keep');
  });

  testWidgets('hover raises button, press lowers it; disabled stays still', (
    tester,
  ) async {
    int taps = 0;
    Future<void> show(bool enabled) => tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PhysicalButton(
              child: ElevatedButton(
                onPressed: enabled ? () => taps++ : null,
                child: const Text('Action'),
              ),
            ),
          ),
        ),
      ),
    );
    await show(true);
    final mouse = await tester.createGesture(kind: ui.PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    await mouse.moveTo(tester.getCenter(find.text('Action')));
    await tester.pumpAndSettle();
    final motion =
        find
            .descendant(
              of: find.byType(PhysicalButton),
              matching: find.byType(AnimatedContainer),
            )
            .first;
    expect(tester.widget<AnimatedContainer>(motion).transform!.entry(1, 3), -3);
    await mouse.down(tester.getCenter(find.text('Action')));
    await tester.pumpAndSettle();
    expect(tester.widget<AnimatedContainer>(motion).transform!.entry(1, 3), 1);
    await mouse.up();
    await tester.pumpAndSettle();
    expect(taps, 1);
    await show(false);
    await tester.pumpAndSettle();
    expect(tester.widget<AnimatedContainer>(motion).transform!.entry(1, 3), 0);
    await mouse.removePointer();
  });
}
