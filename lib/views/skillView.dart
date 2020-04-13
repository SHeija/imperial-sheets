import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/skillTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';

class SkillView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Skill> skills = Provider.of<CharacterModel>(context).getSkills();
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 190/108,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SkillTile(skills[index], index);
              },
              childCount: skills.length,
            ),
          ),
        ),
      ],
    );
  }
}
