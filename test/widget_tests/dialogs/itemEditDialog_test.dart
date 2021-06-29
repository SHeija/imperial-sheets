import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
  group('ItemEditDialog', (){
    testWidgets('renders correctly', (WidgetTester tester) async{
      final Item item = Item.blank();
      final Widget widget = MaterialApp(
        home: ItemEditDialog(item)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(ItemEditDialog), matchesGoldenFile('itemEditDialog.png'));
    });
  });
}