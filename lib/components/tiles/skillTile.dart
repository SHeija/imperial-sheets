import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/skillEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class SkillTile extends StatelessWidget {
  SkillTile({@required this.skill, @required this.index, this.stat});

  final Skill skill;
  final int index;
  final Stat stat;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return SkillEditDialog(skill);
      },
    );
    if (result != null) {
      final Character character = HiveProvider.of(context).getActiveCharacter();
      character.skills[index] = skill;
      character.save();
    }
  }

  // TILE
  @override
  Widget build(BuildContext context) {
    const double cellPadding = 8.0;
    bool _hasSubSkill = skill.subSkill != null && skill.subSkill != '';

    return GestureDetector(
      onLongPress: () => _showEditDialog(context),
      child: Card(
        child: Column(
          children: <Widget>[
            Table(
              //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.70),
                1: FractionColumnWidth(0.30)
              },
              children: [
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            skill.canHaveMultiple()
                                ? skill.name + ':'
                                : skill.name,
                            style: Theme.of(context).textTheme.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          _hasSubSkill
                              ? Text(skill.subSkill,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.subtitle)
                              : Container(),
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: cellPadding,
                          top: cellPadding,
                          right: cellPadding),
                    ),
                    Container(
                      child: Text(skill.getBonusString(),
                          style: Theme.of(context).textTheme.title),
                      padding: EdgeInsets.only(
                          left: cellPadding,
                          top: cellPadding,
                          right: cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(skill.stat,
                              style: Theme.of(context).textTheme.body1),
                          padding: EdgeInsets.only(
                              left: cellPadding,
                              bottom: cellPadding,
                              right: cellPadding),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: StepIndicator(
                            steps: 4,
                            currentSteps: skill.stage,
                          ),
                          padding: EdgeInsets.only(
                              left: cellPadding, right: cellPadding),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                    Container(
                        child: Chip(
                            label: Text(
                                (stat.value + skill.getBonus()).toString()),
                            padding: EdgeInsets.all(0)),
                        padding: EdgeInsets.only(
                            left: cellPadding, right: cellPadding),
                        alignment: Alignment.topCenter),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
