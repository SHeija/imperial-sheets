import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/skillEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';
import '../../utils/constants.dart' as Constants;

void main() {
  group('SkillEditDialog', () {
    testWidgets('renders correctly w/ canHasMultiple=false',
        (WidgetTester tester) async {
      final Skill skill = Skill.notKnown(Constants.parry, Constants.WS);
      final Widget widget = MaterialApp(
        home: SkillEditDialog(skill),
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(SkillEditDialog), matchesGoldenFile('skillEditDialog.png'));
    });

    testWidgets('renders correctly w/ canHasMultiple=true',
        (WidgetTester tester) async {
      final Skill skill =
          Skill.notKnown(Constants.linguistics, Constants.linguistics)
            ..subSkill = 'High Gothic';
      final Widget widget = MaterialApp(
        home: SkillEditDialog(skill),
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(SkillEditDialog), matchesGoldenFile('skillEditDialogMultiple.png'));
    });
  });
}
