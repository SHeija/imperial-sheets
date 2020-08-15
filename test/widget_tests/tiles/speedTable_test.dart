import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/data/speedTable.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import '../../utils/constants.dart' as Constants;

void main() {
  testWidgets('Speedtable renders correctly', (WidgetTester tester) async {
    final Character mockCharacter = Character.blank()
    ..stats = [
      Stat(Constants.AG, 'AG', 30, 1),
    ];
    final Widget widget = MaterialApp(
      home: Container(
        child: SpeedTable(
          character: mockCharacter,
        ),
      ),
    );
    await tester.pumpWidget(widget);
    expect(find.text('Half move'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Full move'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('Charge'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('Run'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
  });
}