import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:compi/ui/core/physical_button.dart';
import 'package:compi/ui/core/profile_photo.dart';
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

  test(
    'photo persists locally and logout preserves learning progress',
    () async {
      SharedPreferences.setMockInitialValues({'user_progress': 'keep'});
      final prefs = await SharedPreferences.getInstance();
      final student = StudentProvider(prefs);
      await student.save('Vika');
      final bytes = Uint8List.fromList([1, 2, 3]);
      await student.savePhoto(bytes);
      expect(StudentProvider(prefs).photo, bytes);
      await expectLater(
        student.savePhoto(Uint8List(1024 * 1024 + 1)),
        throwsArgumentError,
      );
      expect(student.photo, bytes);
      await student.logout();
      expect(StudentProvider(prefs).photo, isNull);
      expect(prefs.getString('user_progress'), 'keep');
    },
  );

  testWidgets('photo conversion bounds dimensions without stretching', (
    tester,
  ) async {
    await tester.runAsync(() async {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      canvas.drawColor(Colors.blue, BlendMode.src);
      final picture = recorder.endRecording();
      final input = await picture.toImage(800, 400);
      final data = await input.toByteData(format: ui.ImageByteFormat.png);
      final result = await prepareProfilePhoto(data!.buffer.asUint8List());
      final codec = await ui.instantiateImageCodec(result);
      final frame = await codec.getNextFrame();
      expect(frame.image.width, 384);
      expect(frame.image.height, 192);
      expect(result.length, lessThan(1024 * 1024));
      frame.image.dispose();
      codec.dispose();
      input.dispose();
      picture.dispose();
    });
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
