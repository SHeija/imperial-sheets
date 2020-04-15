import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/speedTable.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../components/containers/infoContainer.dart';
import '../components/containers/statContainer.dart';

class MainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Imperial sheets'),
          snap: true,
          floating: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: InfoContainer(Provider.of<CharacterModel>(context).getCharacter()),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: SpeedTable(Provider.of<CharacterModel>(context).getCharacter()),
          ),
        ),
        StatContainer(Provider.of<CharacterModel>(context).getStats()),
      ],
    );
  }
}

/*
Container(
      padding: EdgeInsets.all(8.0),
      color: Theme.of(context).bottomSheetTheme.backgroundColor,
      child: ListView(
        children: <Widget>[
          InfoContainer(Provider.of<CharacterModel>(context).getCharacter()),
          SpeedTable(Provider.of<CharacterModel>(context).getCharacter()),
          StatContainer(Provider.of<CharacterModel>(context).getStats()),
        ],
      ),



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
 */