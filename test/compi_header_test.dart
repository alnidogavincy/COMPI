import 'package:compi/ui/core/compi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CompiHeader uses the home logo without its page subtitle', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CompiHeader(title: 'Petunjuk Latihan', onBack: _doNothing),
        ),
      ),
    );

    expect(
      find.image(const AssetImage('assets/images/profile_wordmark.png')),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.width == 138 && widget.height == 58,
      ),
      findsOneWidget,
    );
    expect(find.text('Petunjuk Latihan'), findsNothing);
    final logoRect = tester.getRect(find.byType(CompiWordmark));
    final logicalWidth =
        tester.view.physicalSize.width / tester.view.devicePixelRatio;
    expect(logoRect.right, greaterThan(logicalWidth / 2));
  });

  testWidgets('CompiBrandHeader omits its page subtitle', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CompiBrandHeader(title: 'SMK TKJ 3D')),
      ),
    );

    expect(
      find.image(const AssetImage('assets/images/compi_header_v2.png')),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.width == 150 && widget.height == 48,
      ),
      findsOneWidget,
    );
    expect(find.text('SMK TKJ 3D'), findsNothing);
  });

  testWidgets('home brand header uses the same smaller logo size', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CompiBrandHeader(title: 'SMK TKJ 3D')),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.width == 150 && widget.height == 48,
      ),
      findsOneWidget,
    );
  });

  testWidgets('login header keeps logo left and places sound action right', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompiHeader(
            title: 'Login',
            action: Container(key: const ValueKey('sound-action'), width: 48),
          ),
        ),
      ),
    );

    final logoRect = tester.getRect(find.byKey(const ValueKey('compi-header-logo')));
    final actionRect = tester.getRect(
      find.byKey(const ValueKey('sound-action')),
    );
    expect(logoRect.left, lessThan(tester.view.physicalSize.width / 2));
    expect(actionRect.left, greaterThan(tester.view.physicalSize.width / 2));
  });
}

void _doNothing() {}
