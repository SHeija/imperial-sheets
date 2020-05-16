import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/skillEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

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

    Future<bool> _confirmDismiss() async {
      return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            child: Text('Delete ${skill.name}: ${skill.subSkill.toString()}?'),
          );
        },
      );
    }

    final Character character = HiveProvider.of(context).getActiveCharacter();

    if (result != null) {
      switch (result['choice']) {
        case DialogChoices.confirm:
          character.skills[index] = result['payload'];
          character.save();
          break;
        case DialogChoices.cancel:
          break;
        case DialogChoices.delete:
          if (await _confirmDismiss()) {
            character.skills.removeAt(index);
            character.save();
          }
          break;
      }
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
          child: SingleChildScrollView(
        child: Table(
          //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FractionColumnWidth(0.70),
            1: FractionColumnWidth(0.30)
          },
          children: [
            TableRow(
              children: <Widget>[
                Container(
                  child: Text(
                    skill.canHaveMultiple() ? skill.name + ':' : skill.name,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  padding: EdgeInsets.only(
                      left: cellPadding, top: cellPadding, right: cellPadding),
                ),
                Container(
                  child: Text(
                    skill.getBonusString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  padding: EdgeInsets.only(
                      left: cellPadding, top: cellPadding, right: cellPadding),
                  alignment: Alignment.center,
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _hasSubSkill
                        ? Container(
                            child: Text(skill.subSkill,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle2),
                            padding: EdgeInsets.only(
                              left: cellPadding,
                            ),
                          )
                        : Container(),
                    Container(
                      child: Text(
                        skill.stat,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      padding: EdgeInsets.only(
                        left: cellPadding,
                        bottom: cellPadding,
                        right: cellPadding,
                      ),
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
                        label: Text((stat.value + skill.getBonus()).toString()),
                        padding: EdgeInsets.all(0)),
                    padding:
                        EdgeInsets.only(left: cellPadding, right: cellPadding),
                    alignment: Alignment.topCenter),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
