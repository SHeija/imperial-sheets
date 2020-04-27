import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/components/tiles/itemTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

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
      expect(find.text(item.name+' '+item.getAmountString()), findsOneWidget);
      expect(find.text(item.description), findsOneWidget);
      expect(find.text(item.getWeight().toString()+' kg'), findsNothing);
      expect(find.text(item.weight.toString()+' kg'), findsOneWidget);
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