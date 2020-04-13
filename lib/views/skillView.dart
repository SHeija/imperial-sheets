import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/skillTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class SkillView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Skill> skills = Provider.of<CharacterModel>(context).getSkills();
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              child: Text('Skills', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 190/100,
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
