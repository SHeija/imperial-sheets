import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/components/dialogs/skillAddDialog.dart';
import 'package:imperial_sheets/components/dialogs/skillEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';
import '../../utils/constants.dart' as Constants;

void main() {
  group('SkillEditDialog', () {
    testWidgets('renders correcly w/ canHasMultiple=false',
        (WidgetTester tester) async {
      final Skill skill = Skill.notKnown(Constants.parry, Constants.WS);
      final Widget widget = MaterialApp(
        home: SkillEditDialog(skill),
      );
      await tester.pumpWidget(widget);

      expect(find.byType(DialogTitleWithButton), findsNothing);
      expect(find.text(skill.name), findsOneWidget);
      expect(find.byType(FormBuilderTouchSpin), findsOneWidget);
      FormBuilderTouchSpin touchSpin =
          tester.firstWidget(find.byType(FormBuilderTouchSpin));
      expect(touchSpin.decoration.labelText, 'Stage');
      expect(touchSpin.initialValue, skill.stage);
      expect(find.byType(FormBuilderTextField), findsNWidgets(1));
      expect(find.widgetWithText(FlatButton, 'Submit'), findsOneWidget);
      expect(find.widgetWithText(FlatButton, 'Regret'), findsOneWidget);
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

      expect(find.byType(DialogTitleWithButton), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsNWidgets(2));
      expect(find.text(skill.subSkill), findsOneWidget);
      FormBuilderTextField textField =
          tester.firstWidget(find.byType(FormBuilderTextField));
      expect(textField.decoration.labelText, 'Subskill');
      expect(find.byType(FormBuilderTouchSpin), findsOneWidget);
      FormBuilderTouchSpin touchSpin =
          tester.firstWidget(find.byType(FormBuilderTouchSpin));
      expect(touchSpin.decoration.labelText, 'Stage');
      expect(touchSpin.initialValue, skill.stage);
      expect(find.widgetWithText(FlatButton, 'Submit'), findsOneWidget);
      expect(find.widgetWithText(FlatButton, 'Regret'), findsOneWidget);
    });
  });
  /*
  testWidgets('SkillAddDialog renders correctly', (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      home: SkillAddDialog(),
    );
    await tester.pumpWidget(widget);

    expect(find.text('Add a skill'), findsOneWidget);
    expect(find.byType(FormBuilderDropdown), findsOneWidget);
    expect(find.byType(FormBuilderTextField), findsNWidgets(2));
    FormBuilderTextField textField =
        tester.firstWidget(find.byType(FormBuilderTextField));
    expect(textField.decoration.labelText, 'Subskill');
    expect(find.byType(FormBuilderTouchSpin), findsOneWidget);
    FormBuilderTouchSpin touchSpin =
        tester.firstWidget(find.byType(FormBuilderTouchSpin));
    expect(touchSpin.decoration.labelText, 'Stage');
    expect(touchSpin.initialValue, 1);
    expect(find.widgetWithText(FlatButton, 'Submit'), findsOneWidget);
    expect(find.widgetWithText(FlatButton, 'Regret'), findsOneWidget);

    await tester.tap(find.byType(FormBuilderDropdown));
    await tester.pump();
    Constants.SKILLS_MULTIPLE.forEach((element) {
      expect(find.text(element), findsNWidgets(2));
    });
  });

 */
}
