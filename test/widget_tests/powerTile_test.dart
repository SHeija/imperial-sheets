import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/components/tiles/powerTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

void main() {
  group('PowerTile', (){

    testWidgets('renders correctly', (WidgetTester tester) async {
      final Power power = Power()
      ..name = 'Psychic Power'
      ..description = 'Description'
      ..action = 'Half Action'
      ..focusPower = 'X'
      ..range = 'X meters'
      ..sustained = 'Yes'
      ..effect = 'Kill all'
      ..subType = 'Boom';
      final widget = MaterialApp(
        home: Container(
          child: PowerTile(power, 1),
        )
      );
      await tester.pumpWidget(widget);
      expect(find.text(power.name), findsOneWidget);
      expect(find.text(power.description), findsOneWidget);
      expect(find.text('Action: ${power.action}'), findsOneWidget);
      expect(find.text('Focus Power: ${power.focusPower}'), findsOneWidget);
      expect(find.text('Range: ${power.range}'), findsOneWidget);
      expect(find.text('Sustained: ${power.sustained}'), findsOneWidget);
      expect(find.text('Effect: ${power.effect}'), findsOneWidget);
      expect(find.text('Subtype: ${power.subType}'), findsOneWidget);
    });

    testWidgets('longpress opens a dialog', (WidgetTester tester) async {
      final Power power = Power()
        ..name = 'Psychic Power'
        ..description = 'Description'
        ..action = 'Half Action'
        ..focusPower = 'X'
        ..range = 'X meters'
        ..sustained = 'Yes'
        ..effect = 'Kill all'
        ..subType = 'Boom';
      final widget = MaterialApp(
          home: Container(
            child: PowerTile(power, 1),
          )
      );
      await tester.pumpWidget(widget);
      await tester.longPress(find.byType(PowerTile));
      await tester.pumpAndSettle();
      expect(find.byType(PowerEditDialog), findsOneWidget);

    });
  });
}