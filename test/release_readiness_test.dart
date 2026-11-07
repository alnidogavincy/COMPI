import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:compi/data/dummy_data.dart';
import 'package:compi/data/models/user_progress_model.dart';
import 'package:compi/data/repositories/progress_repository.dart';
import 'package:compi/ui/providers/learning_progress_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'immediate writes preserve loaded progress and survive disposal',
    () async {
      SharedPreferences.setMockInitialValues({
        'user_progress':
            '{"completedMaterials":["mat_ram_01"],"highestQuizScore":75,"unlockedBadges":[]}',
      });
      final prefs = await SharedPreferences.getInstance();
      final repository = ProgressRepository(prefs);
      final provider = LearningProgressProvider(repository);
      provider.completeMaterial('mat_cpu_01');
      provider.completeMaterial('mat_mb_01');
      provider.updateQuizScore(100);
      provider.dispose();
      await provider.settled;
      final saved = await repository.getProgress();
      expect(
        saved.completedMaterials,
        containsAll(['mat_ram_01', 'mat_cpu_01', 'mat_mb_01']),
      );
      expect(saved.highestQuizScore, 100);
    },
  );
  test('partly invalid local data retains valid IDs and clamps score', () {
    final progress = UserProgressModel.fromJson({
      'completedMaterials': ['old_id', 4, 'old_id'],
      'highestQuizScore': 999,
      'unlockedBadges': null,
    });
    expect(progress.completedMaterials, ['old_id']);
    expect(progress.highestQuizScore, 100);
    expect(progress.unlockedBadges, isEmpty);
  });
  test(
    'all GLBs are complete and use embedded resources for offline viewing',
    () {
      for (final model in dummyComponents.where((c) => c.hasModel)) {
        final bytes = File(model.modelPath).readAsBytesSync();
        final header = ByteData.sublistView(bytes);
        expect(
          header.getUint32(0, Endian.little),
          0x46546c67,
          reason: model.id,
        );
        expect(header.getUint32(4, Endian.little), 2);
        expect(header.getUint32(8, Endian.little), bytes.length);
        final length = header.getUint32(12, Endian.little);
        final json =
            jsonDecode(utf8.decode(bytes.sublist(20, 20 + length))) as Map;
        for (final entry in [
          ...(json['buffers'] as List? ?? []),
          ...(json['images'] as List? ?? []),
        ]) {
          final uri = entry['uri'] as String?;
          expect(
            uri == null || uri.startsWith('data:'),
            isTrue,
            reason: '${model.id}: external resource $uri',
          );
        }
        expect(
          json['extensionsRequired'] ?? [],
          isEmpty,
          reason: '${model.id}: external decoder may be needed',
        );
      }
    },
  );
}
