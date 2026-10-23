import 'package:compi/data/repositories/progress_repository.dart';
import 'package:compi/ui/core/app_theme.dart';
import 'package:compi/ui/features/auth/login_screen.dart';
import 'package:compi/ui/features/profile/developer_identity_screen.dart';
import 'package:compi/ui/features/profile/profile_screen.dart';
import 'package:compi/data/model_credits.dart';
import 'package:compi/ui/features/profile/model_credits_screen.dart';
import 'package:compi/ui/providers/learning_progress_provider.dart';
import 'package:compi/ui/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('logout clears identity and routes, preserving local progress', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    const savedProgress =
        '{"completedMaterials":["mat_ram_01"],"highestQuizScore":75,"unlockedBadges":[]}';
    SharedPreferences.setMockInitialValues({
      StudentProvider.key: 'Vika',
      'user_progress': savedProgress,
    });
    final prefs = await SharedPreferences.getInstance();
    final student = StudentProvider(prefs);
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: student),
          ChangeNotifierProvider(
            create: (_) => LearningProgressProvider(ProgressRepository(prefs)),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigator,
          theme: AppTheme.lightTheme,
          home: const Scaffold(),
        ),
      ),
    );
    navigator.currentState!.push(
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Identitas Pengembang'), findsOneWidget);
    expect(find.text('Nama belum diisi'), findsNothing);
    await tester.tap(find.text('Identitas Pengembang'));
    await tester.pumpAndSettle();
    expect(find.byType(DeveloperIdentityScreen), findsOneWidget);
    expect(find.text('Muhammad Alnido Gavincy'), findsOneWidget);
    expect(find.text('Raehan'), findsOneWidget);
    expect(find.text('Anissa Vika Anandari'), findsOneWidget);
    expect(find.text('NPM'), findsNWidgets(3));
    expect(find.text('Asal'), findsNWidgets(3));
    expect(find.text('Alamat'), findsNothing);
    expect(find.text('Instagram'), findsNWidgets(3));
    expect(find.text('Belum diisi'), findsNothing);
    expect(find.text('2413025059'), findsOneWidget);
    expect(find.text('2413025033'), findsOneWidget);
    expect(find.text('2413025005'), findsOneWidget);
    expect(find.text('Bandar Lampung'), findsOneWidget);
    expect(find.text('Tulang Bawang Barat'), findsOneWidget);
    expect(find.text('Lampung Tengah'), findsOneWidget);
    expect(find.text('@alnido.gav19'), findsOneWidget);
    expect(find.text('@_raehann25'), findsOneWidget);
    expect(find.text('@ansvika__'), findsOneWidget);
    expect(find.text('S1 Pendidikan Teknologi Informasi'), findsNWidgets(3));
    expect(find.text('Universitas Lampung'), findsNWidgets(3));
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Kredit Model 3D'));
    await tester.tap(find.text('Kredit Model 3D'));
    await tester.pumpAndSettle();
    expect(find.byType(ModelCreditsScreen), findsOneWidget);
    await tester.tap(find.text('AM4 Cpu [ Free ]'));
    await tester.pumpAndSettle();
    expect(
      find.text(modelCredits['assets/models/cpu_am4.glb']!),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Logout'));
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(student.hasIdentity, isFalse);
    expect(prefs.containsKey(StudentProvider.key), isFalse);
    expect(StudentProvider(prefs).hasIdentity, isFalse);
    expect(prefs.getString('user_progress'), savedProgress);
    expect(navigator.currentState!.canPop(), isFalse);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );
    expect(tester.takeException(), isNull);
  });
}
