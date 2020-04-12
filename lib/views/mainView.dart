import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/speedTable.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../components/containers/infoContainer.dart';
import '../components/containers/statContainer.dart';

class MainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Theme.of(context).bottomSheetTheme.backgroundColor,
      child: ListView(
        children: <Widget>[
          InfoContainer(Provider.of<CharacterModel>(context).getCharacter()),
          SpeedTable(Provider.of<CharacterModel>(context).getCharacter()),
          StatContainer(Provider.of<CharacterModel>(context).getStats()),
        ],
      ),
    );
  }
}