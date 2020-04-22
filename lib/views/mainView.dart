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
          floating: true,
          elevation: Theme.of(context).appBarTheme.elevation,
          forceElevated: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: InfoContainer(Provider.of<CharacterModel>(context).getCharacter()),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          sliver: SliverToBoxAdapter(
            child: SpeedTable(),
          ),
        ),
        StatContainer(Provider.of<CharacterModel>(context).getStats()),
      ],
    );
  }
}