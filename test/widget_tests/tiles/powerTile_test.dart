import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/components/tiles/powerTile.dart';
import 'package:imperial_sheets/models/attributes.dart';

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
        home: Scaffold(
          body: Container(
            child: PowerTile(power, 1),
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(PowerTile), matchesGoldenFile('powerTile.png'));
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
        home: Scaffold(
          body: Container(
            child: PowerTile(power, 1),
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.longPress(find.byType(PowerTile));
      await tester.pumpAndSettle();
      expect(find.byType(PowerEditDialog), findsOneWidget);

    });
  });
}