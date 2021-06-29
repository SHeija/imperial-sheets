import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';

void main() {
  group('PowerEditDialog', (){
    testWidgets('renders correctly w/ isNew = false', (WidgetTester tester) async{
      final Power power = Power.blank();
      final Widget widget = MaterialApp(
        home: PowerEditDialog(power)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(PowerEditDialog), matchesGoldenFile('powerEditDialog.png'));
    });

    testWidgets('renders correctly w/ isNew = true', (WidgetTester tester) async{
      final Power power = Power.blank();
      final Widget widget = MaterialApp(
          home: PowerEditDialog(power, isNew: true,)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(PowerEditDialog), matchesGoldenFile('powerEditDialogNew.png'));
    });
  });
}