import 'package:compi/data/dummy_data.dart';
import 'package:compi/ui/features/games/match_up_screen.dart';
import 'package:compi/ui/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('moves images to shuffled component names and grades on submit', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(900, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const MaterialApp(home: MatchUpScreen()),
      ),
    );
    await tester.pump();

    final images =
        tester
            .widgetList<Image>(find.byType(Image))
            .map((image) => (image.image as AssetImage).assetName)
            .toList();
    expect(
      images,
      containsAll(dummyComponents.map((component) => component.imagePath)),
    );

    final imageOrder =
        tester
            .widgetList<Draggable<String>>(find.byType(Draggable<String>))
            .map((draggable) => draggable.data)
            .toList();
    final nameOrder =
        tester
            .widgetList<DragTarget<String>>(find.byType(DragTarget<String>))
            .map(
              (target) => (target.key! as ValueKey<String>).value.replaceFirst(
                'match-target-',
                '',
              ),
            )
            .toList();
    expect(imageOrder, isNot(nameOrder));

    final submitButton = find.widgetWithText(ElevatedButton, 'Kirim Jawaban');
    expect(tester.widget<ElevatedButton>(submitButton).onPressed, isNull);

    Future<void> place(String imageId, String nameId) async {
      final image = find.byKey(ValueKey('component-image-$imageId'));
      final target = find.byKey(ValueKey('match-target-$nameId'));
      await tester.ensureVisible(image);
      await tester.ensureVisible(target);
      await tester.drag(
        image,
        tester.getCenter(target) - tester.getCenter(image),
      );
      await tester.pumpAndSettle();
    }

    final firstImage = dummyComponents.first;
    final firstName = dummyComponents[1];
    await place(firstImage.id, firstName.id);
    expect(
      find.byKey(ValueKey('empty-source-${firstImage.id}')),
      findsOneWidget,
    );
    expect(
      (tester
                  .widget<Image>(
                    find.descendant(
                      of: find.byKey(ValueKey('placed-image-${firstName.id}')),
                      matching: find.byType(Image),
                    ),
                  )
                  .image
              as AssetImage)
          .assetName,
      firstImage.imagePath,
    );
    expect(find.text('Belum tepat'), findsNothing);

    final movePlacedImage = find.byKey(
      ValueKey('placed-image-drag-source-${firstName.id}'),
    );
    final firstTarget = find.byKey(ValueKey('match-target-${firstImage.id}'));
    await tester.ensureVisible(movePlacedImage);
    await tester.ensureVisible(firstTarget);
    await tester.drag(
      movePlacedImage,
      tester.getCenter(firstTarget) - tester.getCenter(movePlacedImage),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(ValueKey('empty-target-${firstName.id}')),
      findsOneWidget,
    );
    expect(
      (tester
                  .widget<Image>(
                    find.descendant(
                      of: find.byKey(ValueKey('placed-image-${firstImage.id}')),
                      matching: find.byType(Image),
                    ),
                  )
                  .image
              as AssetImage)
          .assetName,
      firstImage.imagePath,
    );

    await tester.tap(find.text('Atur Ulang Pasangan'));
    await tester.pumpAndSettle();

    for (var i = 0; i < dummyComponents.length; i++) {
      final targetIndex =
          i == 0 ? 0 : (i == dummyComponents.length - 1 ? 1 : i + 1);
      await place(dummyComponents[i].id, dummyComponents[targetIndex].id);
    }

    expect(find.text('Benar!'), findsNothing);
    expect(find.text('Belum tepat'), findsNothing);
    expect(
      find.text(
        '${dummyComponents.length} dari ${dummyComponents.length} gambar ditempatkan',
      ),
      findsOneWidget,
    );
    expect(tester.widget<ElevatedButton>(submitButton).onPressed, isNotNull);

    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    expect(
      find.text('1 dari ${dummyComponents.length} jawaban benar'),
      findsOneWidget,
    );
    expect(find.text('Benar!'), findsOneWidget);
    expect(find.text('Belum tepat'), findsNWidgets(dummyComponents.length - 1));
    expect(find.text('Lihat Hasil'), findsOneWidget);
  });
}
