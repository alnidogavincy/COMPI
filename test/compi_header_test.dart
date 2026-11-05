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
      find.image(const AssetImage('assets/images/compi_header_v2.png')),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == 168,
      ),
      findsOneWidget,
    );
    expect(find.text('Petunjuk Latihan'), findsNothing);
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
    expect(find.text('SMK TKJ 3D'), findsNothing);
  });
}

void _doNothing() {}
