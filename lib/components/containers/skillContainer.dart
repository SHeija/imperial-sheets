import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/tiles/skillTile.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class SkillContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Skill> skills = character.skills;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250.0,
        childAspectRatio: 200 / 115,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (skills[index].canHaveMultiple()) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(color: Theme.of(context).errorColor),
              onDismissed: (direction) {
                character.skills.removeAt(index);
                character.save();
              },
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      child: Text(
                          'Delete ${skills[index].name}: ${skills[index].subSkill.toString()}?'),
                    );
                  },
                );
              },
              child: SkillTile(
                skill: skills[index],
                index: index,
                stat: character.getThisStat(skills[index].stat),
              ),
            );
          } else {
            return SkillTile(
              skill: skills[index],
              index: index,
              stat: character.getThisStat(skills[index].stat),
            );
          }
        },
        childCount: skills.length,
      ),
    );
  }
}
