import 'dart:io';
import 'package:compi/data/dummy_data.dart';
import 'package:compi/data/model_credits.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Cooling System has a bundled GLB and attribution', () {
    final cooling = dummyComponents.singleWhere((c) => c.id == 'cooling');
    expect(cooling.hasModel, isTrue);
    expect(cooling.modelPath, 'assets/models/cooling.glb');
    final file = File(cooling.modelPath).openSync();
    try {
      expect(file.readSync(4), [103, 108, 84, 70]);
    } finally {
      file.closeSync();
    }
    expect(modelCredits[cooling.modelPath], contains('Corsair H150i'));
  });
  test(
    'eight illustrated components have lessons and eight actual GLB models',
    () {
      expect(dummyComponents.length, 8);
      expect(dummyComponents.where((c) => c.hasModel).length, 8);
      expect(dummyMaterials.length, 16);
      expect(
        dummyMaterials.map((m) => m.id).toSet().length,
        dummyMaterials.length,
      );
      for (final component in dummyComponents) {
        expect(
          File(component.imagePath).existsSync(),
          isTrue,
          reason: component.imagePath,
        );
        expect(
          dummyMaterials.any((m) => m.componentId == component.id),
          isTrue,
        );
        expect(
          dummyQuizQuestions.any((q) => q.componentId == component.id),
          isTrue,
        );
        if (component.hasModel) {
          final header = File(component.modelPath).openSync();
          expect(header.readSync(4), [103, 108, 84, 70]);
          header.closeSync();
        }
      }
      expect(
        dummyComponents.singleWhere((c) => c.id == 'cooling').hasModel,
        isTrue,
      );
      for (final id in [
        'mat_mb_01',
        'mat_mb_02',
        'mat_cpu_01',
        'mat_cpu_02',
        'mat_ram_01',
        'mat_ram_02',
        'mat_vga_01',
        'mat_vga_02',
      ]) {
        expect(
          dummyMaterials.any((m) => m.id == id),
          isTrue,
          reason: 'Existing progress IDs must remain valid',
        );
      }
    },
  );
}
