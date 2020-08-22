import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
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
      expect(find.byType(DialogTitleWithButton), findsOneWidget);
      expect(find.text('Edit ${armor.name}'), findsOneWidget);
      expect(find.byType(FormBuilderTouchSpin), findsOneWidget);
      FormBuilderTouchSpin touchSpin = tester.firstWidget(find.byType(FormBuilderTouchSpin));
      expect(touchSpin.decoration.labelText, 'Amount');
      expect(touchSpin.initialValue, armor.amount);
      expect(find.byType(FormBuilderTextField), findsNWidgets(9));
      expect(find.byType(FormBuilderSwitch), findsOneWidget);
      expect(find.widgetWithText(FlatButton, 'Confirm'), findsOneWidget);
      expect(find.widgetWithText(FlatButton, 'Regret'), findsOneWidget);
    });

    testWidgets('renders correctly w/ isNew = true', (WidgetTester tester) async{
      final Armor armor = Armor.blank();
      final Widget widget = MaterialApp(
          home: ArmorEditDialog(armor, isNew: true,)
      );
      await tester.pumpWidget(widget);
      expect(find.byType(DialogTitleWithButton), findsNothing);
      expect(find.text('Edit ${armor.name}'), findsNothing);
      expect(find.text('Add armor'), findsOneWidget);
      expect(find.byType(FormBuilderTouchSpin), findsOneWidget);
      FormBuilderTouchSpin touchSpin = tester.firstWidget(find.byType(FormBuilderTouchSpin));
      expect(touchSpin.decoration.labelText, 'Amount');
      expect(touchSpin.initialValue, armor.amount);
      expect(find.byType(FormBuilderTextField), findsNWidgets(9));
      expect(find.byType(FormBuilderSwitch), findsOneWidget);
      expect(find.widgetWithText(FlatButton, 'Confirm'), findsOneWidget);
      expect(find.widgetWithText(FlatButton, 'Regret'), findsOneWidget);
    });
  });
}