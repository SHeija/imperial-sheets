import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/talentEditDialog.dart';
import 'package:imperial_sheets/components/tiles/talentTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

void main() {
  group('TalentTile', () {
    final Talent talent = Talent('Quick Draw', 'Bang Bang', 1);

    testWidgets('renders correctly', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: Scaffold(
          body: Container(
            child: TalentTile(
              talent: talent,
              index: 1,
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text(talent.name), findsOneWidget);
      expect(find.text(talent.description), findsOneWidget);
      expect(find.text('Tier ${talent.tier}'), findsOneWidget);
    });

    testWidgets('Longpress opens a dialog', (WidgetTester tester) async{
      final Widget widget = MaterialApp(
        home: Scaffold(
          body: Container(
            child: TalentTile(
              talent: talent,
              index: 1,
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.longPress(find.byType(TalentTile));
      await tester.pumpAndSettle();
      expect(find.byType(TalentEditDialog), findsOneWidget);
    });

  });
}