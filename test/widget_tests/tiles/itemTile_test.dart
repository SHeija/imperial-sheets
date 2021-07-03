import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/components/tiles/itemTile.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
  group('ItemTile', () {
    Item item = Item('Goggles', 'Zey do nothing', 15.0, 2);

    testWidgets('renders correctly', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: Scaffold(
            body: Container(
                child: ItemTile(
                  item: item,
                  index: 1,
                ),
            )
        ),
      );

      await tester.pumpWidget(widget);
      await expectLater(find.byType(ItemTile), matchesGoldenFile('itemTile.png'));
    });

    testWidgets('longpress opens a dialog', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: Scaffold(
            body: Container(
              child: ItemTile(
                item: item,
                index: 1,
              ),
            )
        ),
      );

      await tester.pumpWidget(widget);
      await tester.longPress(find.byType(ItemTile));
      await tester.pumpAndSettle();
      expect(find.byType(ItemEditDialog), findsOneWidget);
    });
  });
}