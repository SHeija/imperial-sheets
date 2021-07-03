import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/armorEditDialog.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
  group('ArmorEditDialog', (){
    testWidgets('renders correctly w/ isNew = false', (WidgetTester tester) async{
      final Armor armor = Armor.blank();
      final Widget widget = MaterialApp(
        home: ArmorEditDialog(armor)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(ArmorEditDialog), matchesGoldenFile('armorEditDialog.png'));
    });

    testWidgets('renders correctly w/ isNew = true', (WidgetTester tester) async{
      final Armor armor = Armor.blank();
      final Widget widget = MaterialApp(
          home: ArmorEditDialog(armor, isNew: true,)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(ArmorEditDialog), matchesGoldenFile('armorEditDialogNew.png'));
    });
  });
}