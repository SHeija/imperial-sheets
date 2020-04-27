import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/skillEditDialog.dart';
import 'package:imperial_sheets/components/tiles/skillTile.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart' as Constants;

void main() {
  group('SkillTile', () {

    final Skill skill = Skill(Constants.stealth, 2, Constants.AG);
    final Skill skillWSubskill = Skill(Constants.forbiddenLore, 2, Constants.AG)
      ..subSkill = 'Mechanicus';

    Character mockCharacter = Character()
    ..stats = [
      Stat(Constants.AG, 'AG', 25, 0),
    ];


    testWidgets('longpress opens a dialog', (WidgetTester tester) async{
      final Widget widget = MaterialApp(
        home: Scaffold(
            body: Container(
              child: ChangeNotifierProvider(
                create: (context) => CharacterModel(),
                child: SkillTile(
                  skill: skill,
                  index: 1,
                  stat: mockCharacter.getThisStat(skill.stat),
                ),
              ),
            )
        ),
      );

      await tester.pumpWidget(widget);
      await tester.longPress(find.byType(SkillTile));
      await tester.pumpAndSettle();

      expect(find.byType(SkillEditDialog), findsOneWidget);
    });

    testWidgets('displayed correctly w/o subskill', (WidgetTester tester) async{

      final Widget widget = MaterialApp(
        home: Scaffold(
            body: Container(
                child: SkillTile(
                  skill: skill,
                  index: 1,
                  stat: mockCharacter.getThisStat(skill.stat),
                ),
            )
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.text(Constants.stealth), findsOneWidget);
      expect(find.text('+10'), findsOneWidget);
      expect(find.text('35'), findsOneWidget);
      expect(find.byType(StepIndicator), findsOneWidget);

    });

    testWidgets('is displayed correctly w/ subskill', (WidgetTester tester) async{
      final Widget widget = MaterialApp(
        home: Scaffold(
            body: Container(
              child: SkillTile(
                    skill: skillWSubskill,
                    index: 1,
                    stat: mockCharacter.getThisStat(skill.stat),
                ),
            )
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text(Constants.forbiddenLore+':'), findsOneWidget);
      expect(find.text('Mechanicus'), findsOneWidget);
      expect(find.text('+10'), findsOneWidget);
      expect(find.text('35'), findsOneWidget);
      expect(find.byType(StepIndicator), findsOneWidget);

    });
  });
}