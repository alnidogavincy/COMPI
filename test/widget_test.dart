import 'package:flutter_test/flutter_test.dart';
import 'package:compi/main.dart';
import 'package:compi/data/repositories/progress_repository.dart';
import 'package:compi/data/repositories/content_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App boots up', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final progressRepo = ProgressRepository(prefs);
    final contentRepo = ContentRepository();

    await tester.pumpWidget(CompiApp(
      progressRepository: progressRepo,
      contentRepository: contentRepo,
    ));

    await tester.pumpAndSettle();
    expect(find.text('COMPI'), findsWidgets);
  });
}
