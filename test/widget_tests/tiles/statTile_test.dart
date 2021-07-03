import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/statEditDialog.dart';
import 'package:imperial_sheets/components/tiles/statTile.dart';
import 'package:imperial_sheets/models/attributes.dart';
import '../../utils/constants.dart' as Constants;

void main() {
  group('StatTile', () {

    testWidgets('renders correctly', (WidgetTester tester) async {
      final Stat stat = Stat(Constants.WP, 'WP', 25, 0);
      final Widget testableWidget = MaterialApp(
        home: Scaffold(
          body: Container(
            child: StatTile(stat,1),
          ),
        ),
      );
      await tester.pumpWidget(testableWidget);
      await tester.pumpAndSettle();

      await expectLater(find.byType(StatTile), matchesGoldenFile('statTile.png'));

      // Check that dialog opens
      await tester.longPress(find.byType(StatTile));
      await tester.pumpAndSettle();
      expect(find.byType(StatEditDialog), findsOneWidget);
    });

    testWidgets('renders correctly w/ unnaturalBonus', (WidgetTester tester) async {
      final Stat stat = Stat(Constants.WP, 'WP', 25, 0)
      ..unnaturalBonus = 3;
      final Widget testableWidget = MaterialApp(
        home: Scaffold(
          body: Container(
            child: StatTile(stat,1),
          ),
        ),
      );
      await tester.pumpWidget(testableWidget);
      await tester.pumpAndSettle();

      await expectLater(find.byType(StatTile), matchesGoldenFile('statTileUnnatural.png'));

      // Check that dialog opens
      await tester.longPress(find.byType(StatTile));
      await tester.pumpAndSettle();
      expect(find.byType(StatEditDialog), findsOneWidget);
    });

  });
}
