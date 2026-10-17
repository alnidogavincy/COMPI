import 'package:compi/data/dummy_data.dart';
import 'package:compi/ui/features/games/match_up_screen.dart';
import 'package:compi/ui/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('checks random placements only after the user submits', (
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
    expect(images, containsAll(dummyComponents.map((c) => c.imagePath)));

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
    expect(
      find.byKey(ValueKey('empty-target-${dummyComponents[0].id}')),
      findsOneWidget,
    );

    Future<void> place(String imageId, String nameId) async {
      final image = find.byKey(ValueKey('component-image-$imageId'));
      final target = find.byKey(ValueKey('match-target-$nameId'));
      await tester.drag(
        image,
        tester.getCenter(target) - tester.getCenter(image),
      );
      await tester.pumpAndSettle();
    }

    final firstImage = dummyComponents[0];
    final firstName = dummyComponents[1];
    final secondName = dummyComponents[2];
    await place(firstImage.id, firstName.id);
    expect(
      find.byKey(ValueKey('empty-source-${firstImage.id}')),
      findsOneWidget,
    );
    expect(
      (tester
                  .widget<Image>(
                    find.byKey(ValueKey('placed-image-${firstName.id}')),
                  )
                  .image
              as AssetImage)
          .assetName,
      firstImage.imagePath,
    );
    expect(
      tester.getSize(find.byKey(ValueKey('placed-image-${firstName.id}'))),
      const Size(84, 112),
    );

    final placedImage = find.byKey(
      ValueKey('placed-image-drag-source-${firstName.id}'),
    );
    final secondTarget = find.byKey(ValueKey('match-target-${secondName.id}'));
    await tester.drag(
      placedImage,
      tester.getCenter(secondTarget) - tester.getCenter(placedImage),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(ValueKey('empty-target-${firstName.id}')),
      findsOneWidget,
    );
    expect(
      (tester
                  .widget<Image>(
                    find.byKey(ValueKey('placed-image-${secondName.id}')),
                  )
                  .image
              as AssetImage)
          .assetName,
      firstImage.imagePath,
    );

    await tester.tap(find.text('Atur Ulang Pasangan'));
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey('empty-source-${firstImage.id}')), findsNothing);
    expect(
      find.byKey(ValueKey('empty-target-${firstName.id}')),
      findsOneWidget,
    );

    for (var i = 0; i < dummyComponents.length; i++) {
      final targetIndex =
          i == 0 ? 0 : (i == dummyComponents.length - 1 ? 1 : i + 1);
      await place(dummyComponents[i].id, dummyComponents[targetIndex].id);
      if (i == 0) {
        final placedImage = find.byKey(
          ValueKey('placed-image-${dummyComponents[targetIndex].id}'),
        );
        expect(placedImage, findsOneWidget);
        expect(
          (tester.widget<Image>(placedImage).image as AssetImage).assetName,
          dummyComponents[i].imagePath,
        );
        expect(find.text('Terisi'), findsOneWidget);
        expect(
          find.byKey(ValueKey('empty-target-${dummyComponents[1].id}')),
          findsOneWidget,
        );
      }
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
