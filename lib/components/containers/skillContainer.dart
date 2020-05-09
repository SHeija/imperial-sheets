import 'package:flutter/material.dart';
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
        childAspectRatio: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
            return SkillTile(
              skill: skills[index],
              index: index,
              stat: character.getThisStat(skills[index].stat),
            );
        },
        childCount: skills.length,
      ),
    );
  }
}
