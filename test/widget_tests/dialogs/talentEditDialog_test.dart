import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/talentEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';

void main() {
  group('TalentEditDialog', (){
    testWidgets('renders correctly w/ isNew = false', (WidgetTester tester) async{
      final Talent talent = Talent.blank();
      final Widget widget = MaterialApp(
        home: TalentEditDialog(talent)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(TalentEditDialog), matchesGoldenFile('talentEditDialog.png'));
    });

    testWidgets('renders correctly w/ isNew = true', (WidgetTester tester) async{
      final Talent talent = Talent.blank();
      final Widget widget = MaterialApp(
          home: TalentEditDialog(talent, isNew: true,)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(TalentEditDialog), matchesGoldenFile('talentEditDialogNew.png'));
    });
  });
}