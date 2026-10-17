import 'package:compi/data/repositories/content_repository.dart';
import 'package:compi/data/repositories/progress_repository.dart';
import 'package:compi/data/dummy_data.dart';
import 'package:compi/main.dart';
import 'package:compi/ui/features/learning/material_detail_screen.dart';
import 'package:compi/ui/providers/learning_progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('tab utama dapat dibuka pada viewport 360x800', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    SharedPreferences.setMockInitialValues({'student_identity': 'Siswa Uji'});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      CompiApp(
        progressRepository: ProgressRepository(prefs),
        contentRepository: ContentRepository(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.text('Selamat Datang!'), findsNothing);
    expect(find.text('COMPI'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();
    expect(find.text('Selamat Datang!'), findsOneWidget);
    await tester.ensureVisible(find.text('Mulai Belajar'));
    await tester.tap(find.text('Mulai Belajar'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Halo, Siswa Uji'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Materi').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Materi Tersedia'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Praktik').last);
    await tester.pumpAndSettle();
    expect(find.text('Pilih Mode Tantangan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('materi CPU dapat dilanjutkan ke materi pertama RAM', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final progressProvider = LearningProgressProvider(
      ProgressRepository(prefs),
    );
    final cpu = dummyComponents.singleWhere(
      (component) => component.id == 'cpu',
    );
    final cpuMaterial = dummyMaterials.singleWhere(
      (material) => material.id == 'mat_cpu_01',
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: progressProvider,
        child: MaterialApp(
          home: MaterialDetailScreen(component: cpu, material: cpuMaterial),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Lanjut ke RAM (Memori)'));
    await tester.tap(find.text('Lanjut ke RAM (Memori)'));
    await tester.pumpAndSettle();

    expect(find.text('Fungsi RAM'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
