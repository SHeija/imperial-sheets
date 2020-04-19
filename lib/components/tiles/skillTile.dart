import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/skillEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class SkillTile extends StatelessWidget {
  SkillTile(this.skill, this.index);
  final Skill skill;
  final int index;

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
      Provider.of<CharacterModel>(context, listen: false).updateSkills(result, index);
    }
  }

  // TILE
  @override
  Widget build(BuildContext context) {
    const double cellPadding = 8.0;
    Character _meta = Provider.of<CharacterModel>(context).getCharacter();
    const smallTitle = TextStyle(
        color: Color(0xdd000000),
        fontFamily: 'Roboto',
        fontSize: 17.0,
        fontWeight: FontWeight.w500);

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
                }, children: [
              TableRow(children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(skill.canHaveMultiple() ? skill.name+':' : skill.name, style: smallTitle),
                      skill.subSkill.isNotEmpty
                          ? Text(skill.subSkill, overflow: TextOverflow.ellipsis, style: smallTitle)
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
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.only(
                      left: cellPadding,
                      top: cellPadding,
                      right: cellPadding),
                  alignment: Alignment.center,
                ),
              ]),
              TableRow(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text(skill.stat,
                          style: Theme.of(context).textTheme.bodyText2),
                      padding: EdgeInsets.only(
                          left: cellPadding,
                          bottom: cellPadding,
                          right: cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: StepIndicator(4, skill.stage,
                          Theme.of(context).accentColor, Colors.grey),
                      padding: EdgeInsets.only(
                          left: cellPadding,
                          right: cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
                Container(
                    child: Chip(
                        label: Text((_meta.getStat(skill.stat).value +
                            skill.getBonus())
                            .toString()),
                        padding: EdgeInsets.all(0)),
                    padding: EdgeInsets.only(
                        left: cellPadding,
                        right: cellPadding),
                    alignment: Alignment.topCenter),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
